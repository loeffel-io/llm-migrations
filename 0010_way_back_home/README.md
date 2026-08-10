# 0010 - way back home

PLEASE DO ONLY `/Users/loeffel/go/src/github.com/mindful-hq/base` FOR NOW! STEP BY STEP.
I already started base but some things are still left i think

## introduction

We are very near to the final release of our project.
The LAST step is that we need to move all our resources from us-central1 to europe-west3.
it was a big mistake in terms of latency to build up all the resources in us-central1.
We call this migration `0010_way_back_home`.

## important

we need to create new branches in all the affected repositories: `chore/loeffel-io/0010`.
some projects does have a `AGENTS.md` file - you must follow the instructions in this file.
if there is no `AGENTS.md` file, the migration needs to be finished
with `bazel build //...` and `bazel test //...` to prove everything works.
i will run the terraform migrations myself when everything is ready.
we do not delete the old `us-central1` resources for now - i will delete them myself if required.
i will create completely new gcp projects for the new resources.

## affected repositories

### stage 1

```text
/Users/loeffel/go/src/github.com/mindful-hq/base # DONE
```

### stage 2

```
/Users/loeffel/go/src/github.com/mindful-hq/global-base # DONE
/Users/loeffel/go/src/github.com/mindful-hq/earth-base
/Users/loeffel/go/src/github.com/mindful-hq/buildkite
```

### stage 3

```text
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-base
```

### stage 4

```text
/Users/loeffel/go/src/github.com/mindful-hq/rules
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-generics
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-gsa
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-ui
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-google-cloud-gke-cluster
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-renovate-config
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/global-tfmodule-ksa
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service-internal-proto
/Users/loeffel/go/src/github.com/mindful-hq/dart-registry
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-config
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service-internal-proto
```

### stage 5

```text
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service
```

## resources

The need to add the `-eu-1` suffix to ALL REGION SPECIFIC resources to prevent name conflicts:

```text
google storage buckets
google gke clusters
google artifact registry
google nat
google redis cluster
...
```

## new gcp projects

`buildkite-382710` is now `base-504915`
`base-504915` is now planned to split up into `base-504915` and the buildkite part `buildkite-504915`. `base-504915` should only keep the basics. `buildkite-504915` will be the new buildkite project and renovate will be removed.
`global-382710` is now `global-504915`
`earth-dev-382708` is now `earth-dev-504915`
`earth-staging-382708` is now `earth-staging-504915`
`earth-production`is now`earth-production-504915`

## fixing naming restrictions

we need to fix the naming restrictions before going live.
a lot of gcp resource names must be really short and unique.

please make sure that the iam gsa names are like this:

```
module "gsa_earth_authentication_service_dev" {
    source = "git@github.com:mindful-hq/global-tfmodule-gsa?ref=v0.1.7"
    gcloud_service_account_account_id = "${var.gcloud_project}-authentication-${substr("service", 0, 1)}-${substr(var.env, 0, 1)}" # <- this is the change
    gcloud_service_account_description = "${var.gcloud_project}-authentication-service-${var.env}"
    gcloud_project_id = var.gcloud_project_id
```

and this:

```
module "gsa_earth_authentication_service_dev_impl" {
    source                             = "git@github.com:mindful-hq/global-tfmodule-gsa?ref=v0.1.7"
    gcloud_service_account_account_id  = "${var.gcloud_project}-authentication-${substr("service", 0, 1)}-${substr(var.env, 0, 1)}-${substr("impl", 0, 1)}" # <- this is the change
    gcloud_service_account_description = "${var.gcloud_project}-authentication-service-${var.env}-impl"
    gcloud_project_id                  = var.gcloud_project_id
```

## terraform upgrades

please upgrade with `td|ts|tp -- init -upgrade` while td is dev, ts is staging, tp is production:

- terraform google and google beta min version: v7.43.0
- tflint google: v0.39.0
- global-tfmodule-ksa: v0.7.0
- global-tfmodule-gsa: v0.7.0 # introduces gsa bucket names with -eu-1 suffix

you are not allowed to do any apply or destroy.
