#!/usr/bin/env bash
# 0009: bump proto versions in a service repo (MODULE.bazel + go.mod)
set -euo pipefail
cd "$1"

# bazel_module_name go_module_suffix version
BUMPS='
global_proto global-proto/v2 2.23.0
earth_content_service_proto earth-content-service-proto 0.12.0
earth_email_service_proto earth-email-service-proto 1.11.0
earth_user_service_proto earth-user-service-proto 0.32.0
earth_billingrevenuecat_service_proto earth-billingrevenuecat-service-proto 0.5.0
earth_iam_service_proto earth-iam-service-proto 0.9.0
earth_language_service_proto earth-language-service-proto 0.9.0
earth_authorization_service_proto earth-authorization-service-proto 0.15.0
earth_billing_service_proto earth-billing-service-proto 0.12.0
earth_emailmailgun_service_proto earth-emailmailgun-service-proto 0.8.0
earth_authentication_service_proto earth-authentication-service-proto 0.25.0
earth_billingstripe_service_proto earth-billingstripe-service-proto 0.9.0
earth_storage_service_proto earth-storage-service-proto 0.14.0
earth_resourcemanager_service_proto earth-resourcemanager-service-proto 0.12.0
earth_email_service_internal_proto earth-email-service-internal-proto 0.9.0
earth_billing_service_internal_proto earth-billing-service-internal-proto 0.10.0
earth_user_service_internal_proto earth-user-service-internal-proto 0.9.0
'

echo "$BUMPS" | while read -r bzl gomod ver; do
	[ -z "$bzl" ] && continue
	if [ -f MODULE.bazel ]; then
		perl -pi -e "s/(bazel_dep\(name = \"$bzl\", version = \")[^\"]*/\${1}$ver/" MODULE.bazel
		perl -0pi -e "s/(module_name = \"$bzl\",\n    remote = \"[^\"]*\",\n    tag = \")v[^\"]*/\${1}v$ver/" MODULE.bazel
	fi
	if [ -f go.mod ]; then
		perl -pi -e "s|(github\.com/mindful-hq/$gomod )v[0-9A-Za-z.+-]*|\${1}v$ver|" go.mod
	fi
done
