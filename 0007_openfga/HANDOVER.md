# 0007 - OpenFGA: Handover / Context for the next agent

Read this together with `README.md` (the four challenges + solutions) and `resourcematrix4.xlsx`
(single source of truth for all resources). This file contains everything decided and done so far,
plus the exact next steps. `open.csv`, `resourcematrix.csv`, `resourcematrix2.csv`, `resourcematrix3.csv`
are outdated drafts, ignore them.

## Architecture recap (verified in code)

- istio ext authz -> earth-authorization-service -> earth-openfga-service (openfga server).
- Only the authorization-service talks to openfga (`internal/openfga/openfga_v1/openfga.go`,
  `BatchWriteTuples` with duplicate-write/missing-delete IGNORE options -> idempotent).
- Services write tuples via outbox tables (`*_batch_write_tuples_outboxes`, built on
  `global-generics/pkg/outbox`) -> outbox worker calls `BatchWriteTuples` gRPC on the
  authorization-service. Flow: service DB tx -> outbox row -> worker -> authz service -> openfga.
- Ext authz checks build object slices like `["project:"+projectRid, "content:"+contentRid]`
  (OR semantics, project is always the fallback) in each service's `internal/service_authorization/**`.
- The ext authz account arrives via istio-validated header `x-mindful-email`
  (`earth-authorization-service/internal/envoy/service/auth/auth_v3/external_auth.go:52`).
- Anonymous callers are checked as `account:*`
  (`internal/service/authorization/model/model_v1/authorization_model.go:133`).
- Each project has its own openfga store. Model: `earth-openfga-service/fga/model.fga` (~1800 lines),
  per-service test yamls `fga/*.fga.yaml`, bazel test via `fga.bzl`.
- Model conventions (header comment): `_` prefixed relations = internal (grants, pass-throughs,
  helpers like `_member`), non-`_` relations = real permissions checked by ext authz. Permission
  naming: `{service}_{resource}_{method}`, relation limit 50 chars (longest is 49!).

## Key decisions (all finalized, do not re-litigate)

1. **account:{firebaseUid}** is subject only (never a path segment, max 128 chars fits user limit).
   The user resource rid is a server generated uuid, decoupled from the uid.
2. **serviceAccount:{rid}** instead of email (PII + the email form breaks the 256 user limit).
   The rid must become a jwt claim. serviceAccount is dual-natured like gcp: subject AND
   policyable resource (`JA: LAZY`, iam service, "after release").
3. **Openfga api limits** (not mysql column limits): object = full `type:id` <= 256 incl. type name,
   user <= 512 postgres / 256 mysql. Depth 4 object ids (255 chars) NEVER fit as object -> hard max
   depth 3 rid segments (= depth 4 incl. project) for any resource with an openfga type.
   Deeper resources inherit from the nearest policied ancestor (gcp does the same: JobRun/Chunk/etc.
   have no setIamPolicy; policies attach shallow).
4. **Policies/bindings are hashed**: `policy = Hash(resourcePath)`, `binding = Hash(resourcePath, roleRid)`.
   They are pure graph join keys: never in urls, never listed, never parsed. `GetIamPolicy` reads the
   service DB, not openfga.
5. **storage object ids are hashed** the same way (`object:{b32sha256:path}`); the api resource name
   keeps the readable path. Storage service resolves hash -> path via an indexed column when it needs
   ListObjects translation (deferred until actually needed).
6. **Hashing happens at service level** via `global-generics` (NOT in the authorization-service):
   keeps the authz proto strict (customer-facing api later). The authz service tuple proto stays at
   openfga limits (`earth-authorization-service-proto/.../authorization_model.proto:175`, user 512 / object 256).
7. **`_role` / `_sku` split** (challenge 3): grants move to `_role`/`_sku` types; new empty resource
   types `role`/`sku` + parent links written at creation. Role/sku policy chains deferred (additive).
   Reason: grant types occupy the whole `_` relation namespace, pass-through relations would collide
   (e.g. `_resourcemanager_project_get` is a grant leaf on role but a pass-through on resources).
   UPDATE (user decision, overrides the old "relation names stay role/sku" note): the grant link
   RELATIONS are prefixed too (`_role` on bindings, `_sku` on entitlements). Non-prefixed `role`/`sku`
   relations exist only as parent links (`role` on project, `sku`/`tier` on service). Internal vs
   public must be unambiguous everywhere. Service tuple writers must write `relation: "_role"`/`"_sku"`.
8. **Parent links always point to the direct AIP parent**, never skip levels:
   `tier -> service -> project`, `sku -> service`, NOT `tier -> project`. Avoids backfills when a level
   becomes policyable.
9. **service** is a future resourcemanager resource (currently only checked by billing/billingstripe
   ext authz). Type + `service -> project` link needed at go live (seeder ok until resourcemanager owns it).
10. **Contextual tuple** for `group:all-authenticated-accounts` (challenge 1 / README). Constant per
    account -> no cache fragmentation. Rule: contextual tuples may only assert facts derivable from
    trusted request context (the verified jwt). Never use them for ownership/existence facts.
11. **Group rids rename** = the allUsers/allAuthenticatedUsers rename: `group:all-users` -> `all-accounts`
    (auth seeder `internal/seeder/account/account_v1/account.go:41`, resourcemanager
    `internal/database/model/model_v1/project_policy.go:488,499,542,553,602,614` - TODOs already there),
    `group:all-authenticated-users` -> `all-authenticated-accounts`. The `google.iam.v1.Policy` member
    mapping already uses the new names (`GetAllAccounts()`/`GetAllAuthenticatedAccounts()`).
12. **Groups** (customer-facing) come post-go-live, live in the user-service (FK integrity, mirrors the
    organization/membership pattern), members are accounts only (no service accounts, stricter than
    google by design). GroupMembership: design TBD (self-leave via group relation vs. full chain).
13. **b2b is disabled for go live**: organization, membership, membershipInvitation, organization
    billing/entitlements, content collections. Model types + outbox code stay, endpoints unreachable.
    Invitation flow must never write `account:{email}` tuples when it comes back (resolve at accept time).
14. **Lazy policies** (challenge 2): `JA: LAZY` = type + parent link at creation, policy/binding chain
    written on `SetIamPolicy` (full chain in one BatchWriteTuples incl. resource -> policy link).
    Works because ext authz always checks project as fallback. Delete of a lazily-policied resource must
    delete the (possibly existing) policy chain: ids are deterministic hashes, recompute from the stored
    `google.iam.v1.Policy` in the service db; missing-delete is IGNOREd, so it is safe.
15. **Instant (non-lazy) tuples at creation** only for: project (policy+binding, exists), user
    (userPolicy + userBinding:{rid}/user-user-admin + account tuples, exists in `user.go:531`),
    userEntitlement (sku + account tuples, exists in `user_entitlement.go:929`).
16. Known model bug to NOT copy: `content_instructorImage_*` relations on `project` point at
    `_content_instructorProfile_*` (model.fga:186-193, copy-paste).
17. Ext authz checks against non-existing types must be removed: `contentInfo:`, `contentImage:`,
    `contentAudio:`, `contentVideo:`, `instructorProfile:`, `instructorImage:`, `tagInfo:`,
    `categoryInfo:` object entries in content-service service_authorization files (the types do not
    exist in the model; these entries can never match).
18. Anonymous firebase sign-in is NOT supported. If it ever is, the contextual tuple must check the
    `sign_in_provider` claim.
19. `x-mindful-email` header is dead: ext authz reads the account from the EXISTING istio-forwarded
    `x-mindful-uid` header (no new header, no istio change needed for the read side). The istio-side
    removal of the email header itself is still step 12 (user-owned).
20. billing `price` + `userBillingAccount` outboxes are permanent no-ops -> delete (README challenge 2).
21. **Role rids are fixed kebab-case iam names**: `user-user-admin`, `user-organization-admin`,
    `user-membership-admin`, `user-membership-invitation-user`, `storage-object-admin`,
    `content-content-admin` (plus `admin`, `editor`, `customer`, `guest`). No camelCase role rids.
22. **`user_user_create` permission exists** (full chain project/projectPolicy/projectBinding/_role,
    granted to `_role:user-user-admin` in the iam seeder). Added ahead of time so it is not missed.
23. **CreateUserRequest has NO `user_id` field** (removed entirely, `user = 2`, no reserved - the env
    reset makes reserved pointless). User rid is server generated uuid. api-linter not-precedent
    comment on the message. Client-specified ids rejected deliberately (predictable/vanity id risk,
    consistency with all other server-generated rids); purely additive to re-add later.
24. **Contextual tuple lives INSIDE the openfga client** (`internal/openfga/openfga_v1/openfga.go`,
    private `contextualTuples(user)`): derived iff user is `account:` and not `account:*`;
    serviceAccounts get none. NOT a parameter on the `OpenfgaClient` interface (kept clean, callers
    cannot forget or fake the invariant). Do not re-add it to the interface.
25. **Revocation cache bug fixed**: user-events consumer keyed by user rid, check side by account uid.
    Consumer now fetches `User.account` (ACCOUNT read mask) and keys by parsed account rid.
26. Logging: `grpc.account` (uid) + `grpc.tenant` (firebase tenant, carries the project prefix
    `{projectRid}-...`) together identify caller and project. No email anywhere.
27. Old model relations removed entirely (not deprecated): `billingstripe_stripePrice_localize`
    chain, `_auth_account_testAccountIamPermissions`, the dead `lucas@mindful.com` bypasses in the
    authz service_authorization. Breaking-migration rule: delete dead stuff, do not keep it.
28. **Git branches**: `chore/loeffel-io/0007` in every touched repo.
29. **Sku entitlement target is an open set** (platform extensibility like gcp custom permissions):
    customers can add `{type}EntitlementPolicy` types to the model later and use them in skus.
    Therefore NO type whitelist in billing. Generic mapping lives in global-generics
    `authorizationmodelresourcev1.EntitlementPolicyObject(object)`: `{type}:{rid}` ->
    `{type}EntitlementPolicy:{b32sha256:rid}` (rejects empty type/rid, missing `:`, `*` rid).
    `Sku.Object` stays READABLE in db and api (write `content:yoga-1`, read it back identical);
    the hash happens ONLY in the userEntitlement tuple builder. Called directly at the call sites,
    deliberately NOT a method on the Sku struct (user decision). Validated at sku write time
    (FromProto) so malformed objects fail at CreateSku, not in the outbox. Unknown types produce
    inert tuples (check never matches) - same failure mode as gcp unattached policies.
    Content-scoped skus additionally require the content service to write
    `contentEntitlementPolicy -> content` links (step 9 outbox). User adds the target rule to the matrix.

## Status: what is DONE

### global-generics (RELEASED as v0.41.0)

Repo: `/Users/loeffel/go/src/github.com/mindful-hq/global-generics`. Build + tests + vet + fmt green.
**v0.40.0** = tuple object functions; **v0.41.0** (branch `chore/loeffel-io/0007`) adds the generic
`EntitlementPolicyObject(object string)` in `pkg/grpc/resource/mindful/earth/authorization/model/model_v1`
(decision 29, table-driven test included). Services should pin v0.41.0.

- `internal/grpc/tuple/tuple_v1/tuple.go`: `Hash(parts ...string) string` =
  lowercase(`base32.StdEncoding.WithPadding(NoPadding)` of sha256(strings.Join(parts, "/"))), 52 chars.
  Table-driven test in `tuple_test.go`.
- Tuple functions colocated in `pkg/grpc/resource/mindful/earth/**` next to the `{Resource}Name`
  functions. Comment style: 2 lines (`// XObject builds the openfga x object.` + `// Example: "..."`).
  Hash examples written as `{b32sha256:...}`.
- Naming: `{Resource}Object`, `{Resource}PolicyObject`, `{Resource}BindingObject`,
  `{Resource}InternalObject` (`_role:`/`_sku:`), `{Subject}Subject` (account, serviceAccount).
  NO wildcard helpers (pass `"*"` as rid). NO Parse counterparts (one-way by design).
- Server-generated rids are `uuid.UUID` params (user, membership, membershipInvitation,
  userBillingAccount, userEntitlement) - including the pre-existing `*Name`/`Parse*Name` functions for
  user, profile, userBillingInfo, userBillingAccount, userEntitlement, membership
  (`Next[uuid.UUID]`, examples updated). Human rids stay `string`.
- Existing functions: Project(+Policy/Binding/EntitlementPolicy), Service, User(+Policy/Binding),
  Organization(+Policy/Binding), Membership(+Policy/Binding), Object(+Policy/Binding, all hashed id),
  Content(+Policy/Binding/EntitlementPolicy), Instructor/Tag/Category(+Policy/Binding),
  Email(+Policy/Binding), Role+RoleInternal, Sku+SkuInternal, Tier, UserEntitlement, Group,
  AccountSubject, ServiceAccountSubject.
- Deliberately NOT existing: PriceObject, StripePriceObject (no types per matrix),
  membershipInvitation tuple functions (b2b redesign pending), object tests for the resource files
  (user removed them; only the Hash test remains).
- Legacy duplicate BUILD targets exist from an old path move; gazelle does not maintain them ->
  tuple_v1 dep was added manually where needed.
- No `//:format` target in this repo; use `bazel run @rules_go//go -- fmt ./...`.

### Documentation

- `README.md`: all four challenge solutions final (this includes contextual tuples, group renames,
  lazy policy rules, no-op outbox deletion, tuple function rule).
- `resourcematrix4.xlsx`: single source of truth. Reading rule: `Own Iam Policy` decides whether an
  openfga type exists (`JA` = instant tuples, `JA: LAZY` = type + parent link now / policy chain on
  SetIamPolicy, `NEIN` = no type at all; object column on NEIN rows is documentation only).
  Open nits: Group/GroupMembership rows missing, some parent refs show as floats (excel).

## Status: what is NOT done (the actual work, in order)

0. ~~User releases global-generics~~ DONE: v0.40.0 (tuple object functions) + v0.41.0
   (generic EntitlementPolicyObject, decision 29). Services pin v0.41.0; billing already does.
1. ~~**earth-openfga-service**: rewrite `fga/model.fga`~~ DONE (branch `chore/loeffel-io/0007`,
   uncommitted, deployed to the `loeffel-io` env):
   - `_role`/`_sku` types AND relations (decision 7 update), new empty types `role`, `sku`, `service`
     (+ `sku`/`tier` child links), `tier`, `email`; `category`/`service`/`role`/`email` parent links on
     project; `category` added to the project get/configGet unions (was missing, only policied type).
   - decision 16 instructorImage bug FIXED (user approved).
   - kebab-case role rids (decision 21), `user_user_create` chain (decision 22), TODO-remove
     relations deleted (decision 27). All format comments match global-generics v0.40.0.
   - all 7 yamls rewritten + new `earth_email_service.fga.yaml` + BUILD targets. Test-level `tuples:`
     blocks emulate the contextual tuple. Policy/binding ids in yamls stay readable hash preimages
     (model is id-agnostic; production writes `{b32sha256:...}` via global-generics).
   - DSL accepts `_role`/`_sku` type names (verified via fga cli v0.7.8, no fallback naming needed).
2. ~~**earth-authorization-service**~~ DONE (branch `chore/loeffel-io/0007`, uncommitted):
   - contextual tuple inside the openfga client (decision 24), interface unchanged.
   - account from `x-mindful-uid` (decision 19), email out of all logs, tenant added (decision 26).
   - revocation cache fix (decision 25), dead email bypasses removed (decision 27).
   - global-generics bumped to v0.40.0 in go.mod AND MODULE.bazel git_override (both needed!).
     TODO when next touched: bump to v0.41.0 like billing.
   - tuple strings via `AccountSubject`/`GroupObject`/`ProjectObject`.
3. ~~**earth-billing-service**~~ DONE (branch `chore/loeffel-io/0007`; user committed the bulk as
   `c8680fa chore: 0007` and pushed; the review fixes + entitlement resolver landed after that commit -
   check `git status` before continuing). Build + 8/8 tests + format green on global-generics v0.41.0.
   THE REFERENCE IMPLEMENTATION - replicate this pattern in iam/user/email:
   - sku grants on `_sku:` via `SkuInternalObject` + `AccountSubject("*")`; sku/tier -> service link
     tuples on create/delete (`SkuObject`/`TierObject`/`ServiceObject`); tier `ToAuthorizationTuples`
     implemented (link only, lazy policy; outbox wiring existed); entitlement links `relation: "_sku"`.
   - price + userBillingAccount outboxes DELETED (12 files, mains, atlas model list, service call
     sites, `authorizationRequest` helpers, empty builders). Price delete keeps its `Patch` call
     (copies the db id used by repository.Delete - subtle, do not drop when replicating).
   - uuid user rids: `UserBillingAccount.UserRid` + entitlement outbox `UserRid` -> `uuid.UUID`
     varchar(36); filters/repos/service vars/wildcards updated (name parser maps `-` to `uuid.Nil`).
   - service_authorization + TestIamPermissions: all object strings via package functions;
     parent-policied resources check the ancestor (`price -> sku`, `userBillingAccount -> user`);
     `x-mindful-email` -> `x-mindful-uid` in md.Get, envoy header AND both main.go log field maps
     (the log maps were missed first and caught in review - check them in every service!).
   - migrations: 4 new one-DDL goose files (uuid columns, 2 table drops); regenerate via
     `bazel run //db:atlas_migration_sources`, then split by hand if multi-DDL and rehash with
     `atlas migrate hash --dir "file://migrations?format=goose"` (binary under bazel external
     rules_multitool). The atlas test rejects multi-DDL migration files.
   - decision 29 implemented: readable `Sku.Object` + generic `EntitlementPolicyObject` at
     write-validation and tuple-builder sites; fixtures use real b32sha256 hashes
     (`projectEntitlementPolicy:vjojidbbu6yihfr6qrlrvn362nuwvkbs2ggiz54vxwdrn6y23zpa` for "mindful").
4. **earth-iam-service** (NEXT UP; NO AGENTS.md in repo, use billing's conventions): `_role:` rename in
   `internal/database/model/model_v1/role.go:422-457` via `RoleInternalObject`; role -> project link
   tuples; note `role.go:425,448` writes `account:*`/`serviceAccount:*` grant tuples (keep, use
   `AccountSubject("*")`). Binding role link tuples write `relation: "_role"` (decision 7 update).
   Seeded role rids must be the kebab-case names (decision 21). Bump global-generics to v0.41.0
   (go.mod + MODULE.bazel). Check main.go log field maps for `x-mindful-email` (billing lesson).
5. **earth-user-service**: user rid -> uuid (proto v0.26.0 released, `user_id` field GONE - server
   generates the rid, decision 23); remove `group:all-authenticated-users` membership tuples
   (`user.go:530-533,566-569`); default policy/binding tuples via `UserObject`/`UserPolicyObject`/
   `UserBindingObject`/`AccountSubject` with uid instead of email (`user.go:531,541,546,548,551,567...`,
   also `internal/service/user/user_v1/user.go:1906` policy member string); binding role link tuples
   write `relation: "_role"` with rid `user-user-admin` (decisions 7+21);
   membership files keep working but b2b is disabled (email tuples in `membership.go:327...`,
   `membership_invitation.go:368,406` stay untouched or get the uuid treatment if cheap).
6. **earth-resourcemanager-service**: group rid renames (decision 11); projectPolicy/Binding hashing
   via package functions (`project_policy.go` writes `projectBinding:{roleRid}` today -> becomes
   `ProjectBindingObject(projectRid, roleRid)` hashed; verify against model, projectPolicy id today is
   `projectPolicy:mindful`); service seeder or outbox for `service -> project` links (decision 9).
7. **earth-storage-service**: object id hashing via `ObjectObject` (model comment `objectPolicy:1313`
   already says "rid sha256sum" - verify what the code actually writes today); ext authz object strings.
8. **earth-auth-service**: seeder rename `group:all-users` -> `all-accounts` + `AccountSubject`;
   uid instead of email everywhere; serviceAccount rid as jwt claim (needed for decision 2).
9. **earth-content-service**: remove non-existing-type object entries from service_authorization
   (decision 17); tuple strings via package functions; contentPolicy outbox is commented out in
   `cmd/earth_content_service/main.go:355` - clarify with user whether to enable.
10. **earth-email-service**: NEW email type tuples: email -> project link at creation (needs a first
    tuple outbox in this service, copy the billing pattern).
11. ~~**Proto regexes**~~ DONE + RELEASED: user rid + membership rid -> uuid pattern, org billingInfo
    inconsistency fixed, `CreateUserRequest.user_id` removed (decision 23). Released as:
    user-proto v0.26.0, user-internal-proto v0.5.0, billing-proto v0.5.0, billingstripe-proto v0.3.0,
    email-proto v0.2.0. Untouched by design: auth-proto accounts pattern (firebase uid, decision 1),
    authorization-proto tuple limits (decision 6). Generated `.pb.go` are checked in: run the
    `write_source_files` targets (`bazel query 'kind(_write_source_file, //...)'`) after proto edits.
    Known env issue: email-proto `//deployments/production/npm` type-check fails with 403 (npm
    registry auth expired), unrelated to changes - proto tests all pass.
12. **Ext authz header cleanup** (istio config, user-owned): remove the `x-mindful-email` claim
    header from istio RequestAuthentication. The authz service already reads `x-mindful-uid`
    (decision 19), so this is pure removal, not a rename.

Work per repo: branch `chore/loeffel-io/0007` (fork from current branch), `bazel build //...`,
`bazel test //...`, `bazel run //:format` (except global-generics: go fmt, see above), gazelle when
deps change. NEVER commit/push without explicit user approval. Consistency across services is the top
priority: the billing pattern is final, replicate verbatim.

Deploy/commit state (as of this handover): openfga model is DEPLOYED to the user's `loeffel-io` env,
authorization-service rollout to that env was announced by the user. Billing has one user commit
(`c8680fa chore: 0007`, pushed) with the review fixes + decision 29 changes UNCOMMITTED on top.
All other repos: everything uncommitted on `chore/loeffel-io/0007`. The team works on master/staging,
unaffected. Proto releases done: user-proto v0.26.0, user-internal v0.5.0, billing v0.5.0,
billingstripe v0.3.0, email v0.2.0, global-generics v0.41.0.

## Hard constraints (user-imposed)

- Do NOT publish/link proto or global-generics versions; the user releases. Say explicitly when a
  release is the blocker.
- No new dependencies without approval. No touching build/, deployments/, scripts/bazel, tools/format.
- Table-driven tests only (repo convention). Short 2-line function comments like the existing ones.
- b2b + collections stay disabled; do not remove their code.
- The user speaks German-flavored English; challenges use JA/NEIN in the matrix.

## Facts that took long to establish (do not re-derive)

- googleapis: deep resources (5-6 segments) exist but never have setIamPolicy; IAM attaches shallow.
  ServiceAccount is `iam.googleapis.com/ServiceAccount` `projects/{project}/serviceAccounts/{sa}`
  WITH own policy. Groups are cloudidentity, not resourcemanager/iam -> our groups go to user-service.
- openfga proto (openfga/api): TupleKey user `max_bytes: 512`, object pattern `^[^\s]{2,256}$`,
  relation `^[^:#@\s]{1,50}$`. The 128/255/256 numbers in README are mysql column limits.
- The authz service tuple proto mirrors these limits exactly (user 512, object 256) - stays strict.
- Contextual tuple cache: constant per account -> no fragmentation. openfga `ClientContextualTupleKey`.
- `fga model validate` ACCEPTS `_role`/`_sku` type names (verified, fga cli v0.7.8). No fallback needed.
- Service repos pin global-generics TWICE: go.mod AND a `git_override` in MODULE.bazel - bump both
  or bazel silently builds against the old tag.
- fga cli test yamls: a test-level `tuples:` block is passed as contextual tuples to every check in
  that test - exact emulation of what the authz service does at runtime.
- The atlas bazel test allows ONE DDL statement per migration file; the generator emits multi-DDL
  files -> split by hand, then `atlas migrate hash --dir "file://migrations?format=goose"`.
- Check side of parent-policied resources: TestIamPermissions and ext authz check the ANCESTOR object
  (`price -> sku:{service}/{sku}`, `userBillingAccount -> user:{uuid}`), never a nonexistent type.
- b32sha256("mindful") = vjojidbbu6yihfr6qrlrvn362nuwvkbs2ggiz54vxwdrn6y23zpa (test fixture hash).
- Depth math with hashes: worst object string is `membershipInvitationBinding:` + 52 = 80 chars.
  Everything fits with huge headroom. Only unhashed resource objects at depth 3 (191 + type <= 256)
  bind the budget.
