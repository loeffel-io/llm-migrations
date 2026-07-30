we need to apply this kind of patch @0006_hpa/patch.diff to all the services:

```
/Users/loeffel/go/src/github.com/mindful-hq/earth-billingrevenuecat-service
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

the only allowed file to add is `http-client.env.json` if there is a `*.http` file.
do not any new containers to the `service.yaml` files (update only).

this are frontend services which only require the `service.yaml` to be updated for ONLY the existing containers (do not add any new containers):

```
/Users/loeffel/go/src/github.com/mindful-hq/earth-website-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-app-service
/Users/loeffel/go/src/github.com/mindful-hq/earth-hub-service
```
