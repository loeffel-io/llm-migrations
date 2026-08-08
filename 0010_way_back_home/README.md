# 0010 - way back home

## introduction

We are very near to the final release of our project.
The LAST step is that we need to move all our resources from us-central1 to europe-west3.
it was a big mistake in terms of latency to build up all the resources in us-central1.
We call this migration `0010_way_back_home`.

## important

we need to create new branches in all the affected repositories: `chore/loeffel-io/0010`.
some projects does have a `AGENTS.md` file - you must follow the instructions in this file.
if there is no `AGENTS.md` file, the migration needs to be finished with a `bazel build //...` and `bazel test //...` to prove everything works.
i will run the terraform migrations myself when everything is ready.
we do not delete the old `us-central1` resources for now - i will delete them myself if required.
i will create completely new gcp projects for the new resources.

## affected repositories

```text
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-generics
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service
/Users/loeffel/go/src/github.com/mindful-hq/buildkite
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service
/Users/loeffel/go/src/github.com/mindful-hq/global-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-service
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-gsa
/Users/loeffel/go/src/github.com/mindful-hq/rules
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-base
/Users/loeffel/go/src/github.com/mindful-hq/global-aip
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-base
/Users/loeffel/go/src/github.com/mindful-hq/global-ui
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-service
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-google-cloud-gke-cluster
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-renovate-config
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-base
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-ksa
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/dart-registry
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-config
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service-internal-proto
```

## resources

The need to add the `-eu-1` suffix to ALL REGION SPECIFIC resources:

```text
google storage buckets
google gke clusters
google artifact registry
google nat
google redis cluster
...
```

by this we think we are future proof with the naming AND the region resources names should not conflict.
