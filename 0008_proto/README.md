We are very near to the final release of our project.
We now do the last proto projects migrations:

```
/Users/loeffel/go/src/github.com/mindful-hq/earth-content-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-email-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-user-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-iam-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-language-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-authorization-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billing-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-emailmailgun-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-authentication-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingstripe-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-storage-service-proto
/Users/loeffel/go/src/github.com/mindful-hq/earth-resourcemanager-service-proto
```

we need to apply the patch @0008_proto/patch.diff to all the avobe listed services including bumping the `global-proto` version to `v2.23.0`
this needs to be done also in the `pubspec.yaml` and `package.json`.
to bump the package.json file you must run `bazel run -- @pnpm//:pnpm --dir $PWD install --lockfile-only`.
if you encounter an authentication/authorization error, you need to run `bazel run //deployments/production/npm:npmrc`.
if you encounter still an authentication/authorization error, you need to run `bazel clean --expunge` because this is a known issue.
do this in a specific `chore/loeffel-io/0008` branch.
