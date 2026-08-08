# 0009 - Proto bump

we need to make sure that every service has the latest proto versions:

```
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

here are the latest proto versions:

```
earth-content-service-proto │ v0.11.0
earth-email-service-proto │ v1.10.0
earth-user-service-proto │ v0.31.0
earth-billingrevenuecat-service-proto │ v0.4.0
earth-iam-service-proto │ v0.8.0
earth-language-service-proto │ v0.8.0
earth-authorization-service-proto │ v0.14.0
earth-billing-service-proto │ v0.9.0
earth-emailmailgun-service-proto │ v0.7.0
earth-authentication-service-proto │ v0.23.0
earth-billingstripe-service-proto │ v0.7.0
earth-storage-service-proto │ v0.13.0
earth-resourcemanager-service-proto │ v0.11.0
earth-email-service-internal-proto │ v0.8.0
earth-billing-service-internal-proto │ v0.9.0
earth-user-service-internal-proto │ v0.7.0
```

## important (app, hub, website)

this needs to be done also in the `pubspec.yaml` and `package.json`.
to bump the package.json file you must run `bazel run -- @pnpm//:pnpm --dir $PWD install --lockfile-only`.
if you encounter an authentication/authorization error, you need to run `bazel run //deployments/production/npm:npmrc`.
if you encounter still an authentication/authorization error, you need to run `bazel clean --expunge` because this is a known issue.

## status

do this in a specific `chore/loeffel-io/0009` branch.
needs to be run to be finished: `bazel build //...`, `bazel test //...`, `bazel run //:format` (except global-generics: go fmt, see above), gazelle when deps change.
some services does have a `AGENTS.md` file - you must follow the instructions in this file.

```

```
