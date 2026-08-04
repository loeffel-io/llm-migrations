# 0007 - Openfga

We are currently working on the final release of our project.
We've been working on this for round about 5 years now.

Our architecture is based on a microservices architecture.
We use istio ext authz that calls our authorization service that calls our openfga service.
We will reset the whole environment so we don't care about breaking changes!
Before we go live we need to make sure that the openfga service and all our microservices are future proof:

```
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-auth-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service
```

We do implement a lot of the gcp protos like the `google.iam.v1.Policy` and the google aip standards.
The openfga model is located in `/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-service/fga/model.fga`.

## Current challanges we are facing and which we need to solve:

### challenge 1

#### problem

Because of dsgvo etc in germany we need to anonymize the user data in our tuples.
Currently we do use the user email address.
Also we need to make sure that we rename `allUsers` to `allAccounts` and `allAuthenticatedUsers` to `allAuthenticatedAccounts` before we go live.
Also the email is included inside the logging. this needs to be also the firebase uid, best case with project name but not sure if thats easy possible.

I think thats an easy fix.

#### solution

we switch to the firebase uid because its only used for the check. more at solution 4.

- `allUsers`/`allAuthenticatedUsers`: the rename lives in the group rids inside tuples, not in relations:
  rename `group:all-users` -> `group:all-accounts` (auth seeder, resourcemanager project_policy) and
  `group:all-authenticated-users` -> `group:all-authenticated-accounts` (resourcemanager project_policy).
  The `google.iam.v1.Policy` member mapping already uses the new names (`GetAllAccounts()`/`GetAllAuthenticatedAccounts()`).
- `group:all-authenticated-accounts` membership becomes a **contextual tuple**: the authorization service
  adds `account:{uid} -> account -> group:all-authenticated-accounts` to every authenticated check
  (it verified the jwt, so "authenticated" is request context, not stored data). The stored membership
  writes at user creation (user.go) get removed: no lifecycle, no chicken-and-egg at signup, always correct.
  We do not support firebase anonymous sign-in; if that ever changes, the contextual tuple must check the
  `sign_in_provider` claim first.
- the `x-mindful-email` ext authz header is dead: the authz service reads the account from the existing `x-mindful-uid` header, no email in headers/logs. istio-side removal of the email header is a separate user-owned step.
- membership invitations are keyed by email and would write `account:{email}` tuples.
  b2b is disabled for go live, so this is out of scope for now. before b2b goes live: resolve email -> account at invitation accept time, never write email tuples.
- service accounts also stop using email: `serviceAccount:{serviceAccountRid}` (see solution 4).
- content collections are disabled for go live, so this is out of scope for now.

### challenge 2

#### problem

A lot of our services are not creating resources including the openfga tuples yet.
We need to make sure that the tuple creation and the outboxes for this are done and consistent before be go live.
That means there need to be a resource, binding and policy tuple type for each resource.

#### solution

The single source of truth for all resources is `resourcematrix4.xlsx`:

- `Own Iam Policy` decides whether a resource gets an openfga type: `JA` (instant policy at creation), `JA: LAZY` (type + parent link at creation, policy/binding tuples on `SetIamPolicy`) or `NEIN` (no type at all).
- The `OpenFGA Object` column on `NEIN` rows only documents the format IF a type ever exists; the policy column decides whether it does. Ext authz checks `NEIN` resources on the nearest policied ancestor with the child permission (e.g. `content:` + `content_contentInfo_get`).
- Ext authz object entries for non-existing types (e.g. `contentInfo:`, `contentImage:`, `instructorProfile:`) must be removed from the service_authorization checks.

We need to make sure that the tuple creation and the outboxes for this are done and consistent before be go live.
_Its not required to create the binding and policy tuples for each resource before we go live._
Policies/bindings are created lazily on `SetIamPolicy` (full chain in one BatchWriteTuples). This works because ext authz always checks `project:` as fallback.

Exceptions and rules:

- Every resource with an openfga type always writes its resource -> parent link tuple at creation, pointing to the direct AIP parent, never skipping levels (e.g. `tier -> service -> project`).
- `service -> project` links are seeded in the resourcemanager mindful project seeder (`serviceRids` list, currently only `content`) until dedicated servicemanagement/serviceusage services exist (gcp-style; services will NOT be a resourcemanager resource).
- `google.iam.v1.Policy` forms: binding role = resource name (`projects/{p}/roles/{r}`), members = prefixed principal ids (`account:{accountRid}`, `serviceAccount:{serviceAccountRid}`, `group:{rid}`) - gcp convention, never resource names for members.
- End-user-owned resources with their own policy chain (`user`) must write their default policy + binding + account tuples at creation, otherwise the owner is locked out. `userEntitlement` writes its sku/account tuples at creation.
- `user_user_create` is granted to the `customer` role (bound to `group:all-authenticated-accounts`, satisfied by the contextual tuple), NOT to `user-user-admin`: at signup the user resource does not exist yet, so its own binding cannot grant the create. Anonymous (`guest`) does not get it.
- `userBillingAccount`, `userBillingInfo`, `profile` need nothing: they are parent-policied via the `user` type.
- b2b (`organization`, `membership`, `membershipInvitation`) is disabled and will not go live.
- groups: post-go-live, design TBD (self-leave via group relation vs. full membership chain like organization). the two well-known groups `all-accounts` (wildcard, seeded) and `all-authenticated-accounts` (contextual, see challenge 1) exist at go live.
- `GetIamPolicy` on a never-policied resource returns an empty policy from the service db (no fga read).
- billing: the `price` and `userBillingAccount` batch write tuples outboxes are permanent no-ops
  (price writes nothing per the matrix, userBillingAccount is parent-policied via `user`).
  Delete both outboxes incl. their tables, `ToAuthorizationTuples` methods and main.go wiring.
  billingstripe correctly has no tuple outbox at all and stays that way.

### challenge 3

Currently we use the openfga `sku` and `role` type to set the iam permissions.
I think this could be problematic because the `sku` and `role` should have their own resource, binding and policy tuple types,
that we can policy the iam permissions for.
Could be that we need internal types for this like `_role` and `_sku`, but very unsure.

#### solution

we need to switch to `_role` and `_sku` to make it possible that `role` and `sku` can later have their own policy.
`_role` and `_sku` is only for internal grants (they keep all the `_permission` relations, bindings/entitlements point to them).
The grant link relations are prefixed too: bindings use `define _role: [_role]`, entitlements `define _sku: [_sku]`.
The non-prefixed `role`/`sku` relations exist only as parent links on `project`/`service`. Internal vs public is always visible from the name.

Why the split is needed: the grant types occupy the whole `_` relation namespace (e.g. `_resourcemanager_project_get` as grant leaf), so a resource type can never share the type with the grants (a resource needs the same relation names as hierarchy pass-throughs). Renaming relations is impossible (50 char relation limit, we are already at 49).

What we do now (per challenge 2 rules, avoids a backfill migration later):

- rename `type role` -> `type _role`, `type sku` -> `type _sku` in the model and all tuple writers (iam, billing, user seeder); tuple writers also write `relation: "_role"`/`"_sku"` on bindings/entitlements
- create the empty resource types `role` and `sku` + their parent links (`role -> project`, `sku -> service`)
- write the `role -> project` and `sku -> service` link tuples in the create/delete outboxes

What we defer (purely additive later, zero tuple migration): `rolePolicy`/`roleBinding`, `skuPolicy`/`skuBinding`, the non-underscore `iam_role_*`/`billing_sku_*` relations and `SetIamPolicy` support.

Sku entitlement targets: `Sku.Object` is an open set (`{type}:{rid}`), NOT a whitelist - customers can add new `{type}EntitlementPolicy` types to the model later, like custom iam permissions. The value stays readable in db and api; only the userEntitlement tuple builder resolves it via the generic `authorizationmodelresourcev1.EntitlementPolicyObject` to `{type}EntitlementPolicy:{b32sha256:rid}`. Validated at sku write time. Currently resolvable at go live: `project:` and `content:` (content needs its entitlement policy link outbox enabled).

### challenge 4

#### problem

This could be the biggest challenge.
The openfga string limits are problematic.

```
object type is at most 128 characters (down from 256)
object id is at most 255 characters (down from 256)
user is at most 256 characters (down from 512)
```

With this our resource rids are getting in trouble. Currently we have a limit of `63` characters for the resource rid like google does.
There are exceptions:

- The firebase account/user uid can have up to `128` characters.
- The storage object rid can be very long.

We could hash those rids and go with a maximum of 63\*4 = 252 characters limit in our resource names and limit our resource name total depth to `4` which could be enough.
For example our user billing account resource name is `projects/mindful/users/abc/billingAccounts/def`
that would have for example a userBillingAccount policy binding `{user}/{userBillingAccount}/{userBillingAccountBinding}` which ends up in `63+1+63+1+63` string length and this only with a resource name depth of `3`.
That means the maximum depth is `projects/mindful/{resource1}/abc/{resource2}/def/{resource3}` which is `63+1+63+1+63+1+63` = 255 string length including the policy binding
(ignoring the project prefix, each project has its own openfga store).
Hashing everything or string parts only (especially the firebase account/user uid or object rid) could be a easy but what about the Openfga `ListObjects` results, the could be unreadable and could break the microservice infrastructure.

#### solution

Note on the limits: the numbers above are the mysql column limits. The real api-level limits are: object = full `type:id` string <= 256, user <= 512 on postgres (<= 256 on mysql). The object limit is enforced by the api on every datastore, so postgres does not buy us more depth.

The maximum length of any rid must be `63` characters.
The account:{firebaseUid} is subject only (never a path segment; the user resource has its own rid).
The service account does not use email: serviceAccount:{serviceAccountRid} (rid must be a jwt claim for the check).
The object rid will be base32 sha256 encoded which is around 52 characters (internal only, the api resource name keeps the object path; the storage service resolves hash -> path via an indexed column for ListObjects).
The user rid will be uuid with a max length of `36` characters (decoupled from the firebase uid).
The firebase uid lives in the user's `account_rid` column (unique per project); `users/me` resolves via this column using the verified `x-mindful-uid` header (`ParseUserMeName`, only GetUser accepts the alias). Email-based aliases are forbidden forever (PII in urls/logs).
The policies and bindings will be sha256 encoded which is `64` characters, because they will never see the sunlight (ListObjects, Resource names, etc):

```
policy  = sha256(resourcePath)
binding = sha256(resourcePath + "/" + roleRid)
```

Result: the maximum depth is `4` including the project prefix.
The api can take longer resource names but everything with the depth of `5` or more can't have a iam policy
and inherits its iam check from the nearest policied ancestor (ext authz checks the ancestor object with the child permission, like gcp does).

Current status: our deepest policied resources are depth 3, deepest resource names are depth 4 and not policied. Everything already conforms.

All tuple strings (objects, users, policies, bindings, hashes) are built exclusively via the
`global-generics` resource package functions (`{Resource}Object`, `{Resource}PolicyObject`,
`{Resource}BindingObject`, `{Resource}InternalObject`, `{Subject}User`), colocated with the
`{Resource}Name` functions. Services and ext authz never concatenate tuple strings by hand,
so write side and check side can never diverge and the hashing stays invisible at the call sites.

## Conclusion

Lets start building with all the informations you have. btw: do not publish any protos yourself - change the code if needed but do not link to the new version. let me know if i need to do this for you and release a new version.
