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

## pipeline

we migrated the build pipelines from https://github.com/buildkite/charts and https://github.com/EmbarkStudios/k8s-buildkite-plugin to https://github.com/buildkite/agent-stack-k8s.
that requires a `build/buildkite/pipeline.yaml` configuration migration! please see `/Users/loeffel/go/src/github.com/mindful-hq/buildkite-base` and make sure that all other repositories are migrated.
IMPORTANT: after the pipeline migration of a repository, the buildkite pipeline must be switched MANUALLY to the new cluster agent in the buildkite ui (cluster setting on the pipeline) - otherwise the old chart-based agents pick up the job and fail with a `kubernetes-buildkite-plugin` clone error (the `kubernetes` plugin is virtual and only understood by agent-stack-k8s).

## bazel version

we now only support 2 different bazel versions.
please make sure that all other repositories are migrated.
the bazel worksapce version repositories need to use bazelversion 6.6.0 with buildkite pipeline sha256 image checksum: sha256:5e8a214baa9ab294531695663df472d2200f2bb1a150693e81f70f64d24ae4ce
the bazel module version repositories need to use bazelversion 8.6.0 with buildkite pipeline sha256 image checksum: sha256:8a769263e86729929bc1f389d3fa7e5e915c2788fe8c1fa6f2e545e4e094f23d

## affected repositories

### stage 1

```text
/Users/loeffel/go/src/github.com/mindful-hq/base # DONE
```

### stage 2

```
/Users/loeffel/go/src/github.com/mindful-hq/global-base # DONE
/Users/loeffel/go/src/github.com/mindful-hq/earth-base # DONE - ns missing (lazy)
/Users/loeffel/go/src/github.com/mindful-hq/buildkite-base # DONE
```

### stage 3

```text
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-base: sql production db-lightweight-2 zonal; sql dev + staging db-small zonal; mysql ips: dev: 172.17.0.2; staging: 172.17.0.2; production: 172.17.0.2 # DONE
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-base: sql production db-standard1 zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: 172.17.0.10; staging: 172.17.0.10; production: 172.17.0.10; ns zone: dev: c; staging: d; production: c
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-base: sql production db-small zonal; sql dev + staging db-micro zonal # DONE mysql ips: dev: 172.17.0.12; staging: 172.17.0.12; production: 172.17.0.12; ns zone: dev: a; staging: d; production: a
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-base: sql production db-small zonal; sql dev + staging db-micro zonal # DONE mysql ips: dev: 172.17.0.8; staging: 172.17.0.8; production: 172.17.0.8; ns zone: dev: a; staging: d; production: e
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-base # DONE; ns zone: dev: a; staging: c; production: e
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-base: sql production db-standard1 zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: x; staging: x; production: x; ns zone: dev: x; staging: x; production: x
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-base: sql production db-standard1 zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: x; staging: x; production: x; ns zone: dev: x; staging: x; production: x
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-base: sql production db-small zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: x; staging: x; production: x; ns zone: dev: x; staging: x; production: x
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-base: sql production db-standard1 zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: x; staging: x; production: x; ns zone: dev: x; staging: x; production: x
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-base: sql production db-standard1 zonal; sql dev + staging db-micro zonal # DONE sql dev + staging db-micro zonal; mysql ips: dev: x; staging: x; production: x; ns zone: dev: x; staging: x; production: x
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-base
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-base
```

`db-lightweight-2` must be `db-custom-2-3840` tier value to work.
`db-standard-1` must be `db-custom-1-3840` tier value to work.
all repos need to use the mysql 8.4 version and edition `enterprise`

every stage 3 repository needs three additional cross-repo changes:

1. buildkite-base: `earth_<svc>_base_{dev,staging,production}.tf` KSA files (namespace `buildkite`, KSA name `earth-<svc>-base-<env>` = pipeline serviceAccountName, gsa email short form `earth-<svc>-base-<e>@earth-<env>-504915`, locals from locals.tf) + BUILD.bazel entries
2. earth-base: `roles/iam.serviceAccountAdmin` grant on the repo gsa for `buildkite-base-p@buildkite-504915.iam.gserviceaccount.com` in each env's `earth_<svc>_base.tf` (no comments)
3. apply order: earth-base (grants) -> buildkite-base (KSAs) -> switch pipeline cluster in buildkite ui

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
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-openfga-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-service
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

## we go production

its very important that while the migration staging is based on dev and then production is based on staging.
never did the production setup and we need to make sure that production is working. production will be deployed with tags. i think i already prepared that at some places.

## terraform upgrades

please upgrade with `td|ts|tp -- init -upgrade` while td is dev, ts is staging, tp is production:

- terraform google and google beta min version: v7.43.0
- tflint google: v0.39.0
- global-tfmodule-ksa: v0.9.0
- global-tfmodule-gsa: v0.9.0 # introduces gsa bucket names with -eu-1 suffix
- rules (com_github_mindful_hq_rules): v0.19.14 # required for bazel workspace repositories
- .bazelrc file is required for bazel workspace repositories with content:

```
build --action_env=GITHUB_TOKEN
test --test_env=GITHUB_TOKEN
```

you are not allowed to do any apply or destroy.

```

```
