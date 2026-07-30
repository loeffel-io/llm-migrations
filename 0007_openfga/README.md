We are currently working on the final release of our project.
We've been working on this for round about 5 years now.

Our architecture is based on a microservices architecture.
We use istio ext authz that calls our authorization service that calls our openfga service.
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

We do implement a lot of the gcp protos like the `google.iam.v1.Policy`.

Current challanges we are facing and which we need to solve:

# challenge 1

Because of dsgvo etc in germany we need to anonymize the user data in our tuples.
Currently we do use the user email address.
Also we need to make sure that we rename `allUsers` to `allAccounts` and `allAuthenticatedUsers` to `allAuthenticatedAccounts` before we go live.

I think thats an easy fix.

# challenge 2

A lot of our services are not creating resources including the openfga tuples yet.
We need to make sure that the tuple creation and the outboxes for this are done and consistent before be go live.
That means there need to be a resource, binding and policy tuple type for each resource.

# challenge 3

Currently we use the openfga `sku` and `role` type to set the iam permissions.
I think this could be problematic because the `sku` and `role` should have their own resource, binding and policy tuple types,
that we can policy the iam permissions for.

#
