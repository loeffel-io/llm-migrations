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

I think thats an easy fix.

#### solution

we switch to the firebase uid because its only used for the check. more at solution 4.

### challenge 2

A lot of our services are not creating resources including the openfga tuples yet.
We need to make sure that the tuple creation and the outboxes for this are done and consistent before be go live.
That means there need to be a resource, binding and policy tuple type for each resource.

### challenge 3

Currently we use the openfga `sku` and `role` type to set the iam permissions.
I think this could be problematic because the `sku` and `role` should have their own resource, binding and policy tuple types,
that we can policy the iam permissions for.
Could be that we need internal types for this like `_role` and `_sku`, but very unsure.

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

The maximum length of any rid must be `63` characters.
The object rid will be base32 sha256 encoded which is around 52 characters.
The user rid will be uuid with a max length of `36` characters.
The policies and bindings will be sha256 encoded which is `64` characters, because they will never see the sunlight (ListObjects, Resource names, etc):

```
policy  = sha256(resourcePath)
binding = sha256(resourcePath + "/" + roleRid)
```

Result: the maximum depth is `4` including the project prefix.
The api can take longer resource names but everything with the depth of `5` can't be have a iam policy.

## Conclusion

Lets start this brainstorming session. Please take a look at the services and lets discuss the challenges in easy words.
