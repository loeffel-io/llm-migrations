# 0010_way_back_home - migration memory

Working memory for the us-central1 -> europe-west3 migration. Read together
with README.md (rules, stages, db sizing). Keep this file updated after every
repo migration.

## status (as of last session)

| repo | branch | state |
|---|---|---|
| base | chore/loeffel-io/0010 | DONE (uncommitted at time of work) - buildkite split still missing per README |
| global-base | chore/loeffel-io/0010 | DONE, uncommitted |
| earth-base | chore/loeffel-io/0010 | DONE (dev+staging+production), uncommitted - NS rrdatas missing (stage 3) |
| buildkite-base | chore/loeffel-io/0010 | base scaffold DONE (renamed from global-base copy), uncommitted; user adds cluster/agent tf next. bazel 6.6.0 (fixes dyld LC_UUID error on darwin with rules_docker/go builds) |
| buildkite (old repo) | - | legacy us-central1 repo, superseded by buildkite-base |
| earth-openfga-base | chore/loeffel-io/0010 | DONE (dev+staging+production replicated), uncommitted |
| everything else | - | not started |

## the standard migration recipe (per repo)

1. `git checkout -b chore/loeffel-io/0010` (base/earth-base already had it)
2. Check for AGENTS.md (none found so far in: base, global-base, earth-base, earth-openfga-base)
3. Root `vars.bzl`: region -> `europe-west3`, project ids -> `-504915` suffix
   (production previously had NO number: `earth-production` -> `earth-production-504915`)
4. `terraform.bzl`: impersonated SA uses short env form `env[0:1]`
   (e.g. `earth-openfga-base-p@...`). In earth-openfga-base the
   `trim_gcloud_service_account` param was removed entirely - always trim now.
5. `backend.tf`: bucket gets `-eu-1` suffix (e.g. `mindful-earth-base-terraform-dev-eu-1`)
6. gsa module refs -> `?ref=v0.7.0` (v0.7.0 adds `-eu-1` to bucket names internally,
   so `buckets = [...]` lists stay WITHOUT suffix). ksa module -> `?ref=v0.7.0`.
7. GSA account_ids short form: `${var.gcloud_project}-<name>-${substr("service", 0, 1)}-${substr(var.env, 0, 1)}`
   (+ `-${substr("impl", 0, 1)}` for impl). Descriptions keep the full long name.
   For base repos: `earth-<svc>-base-${substr(var.env, 0, 1)}`.
8. `-eu-1` suffix on ALL region-specific resource names: artifact registries,
   gke clusters, sql instances, redis psc subnets/scp, storage buckets (via module).
   NOT on: NAT (one per continent -> `-eu` only, e.g. `earth-nat-dev-eu`),
   global/non-regional things (networks, global addresses, certmaps, waf policies,
   dns, secrets, identity platform), and NOT on the sql peering data-source name
   (`earth-openfga-service-dev-sql` stays, defined in earth-base).
9. `versions.tf`: google + google-beta `>= 7.43.0`; declare kubernetes if used;
   drop unused providers (tls was unused in earth-openfga-base). `required_version = ">= 1.6.2"`.
10. `.tflint.hcl`: google plugin `0.39.0`
11. Lock upgrade: `terraform init -upgrade -backend=false` (new backend buckets do
    not exist yet, so -backend=false; user runs the real `td|ts|tp -- init -upgrade` later).
    Then `terraform validate` + `terraform fmt -check`. `rm -rf .terraform` afterwards.
12. `bazel build //...` && `bazel test //...` must pass. NEVER apply/destroy. NEVER commit unless asked.

## cross-repo references that could not be migrated yet

Marked with comment: `# 0010_way_back_home: stage 3 - uncomment after the owning earth-*-base repo created this gsa`

- global-base/deployments/production/global_proto.tf: 18 commented
  artifact-registry reader grants for earth service/proto GSAs
- global-base/deployments/production/global_ui.tf: 9 commented reader grants
- earth-base (all envs) `subdomains` NS record rrdatas carry copied/old
  nameserver values - real values only known after stage 3 child zones exist
  (README: "earth-base DONE - ns missing")

## provider 7.x breaking changes hit so far

- `google_sql_database_instance.settings.ip_configuration.require_ssl` removed
  -> `ssl_mode = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"` (keep this mode, NOT
  ENCRYPTED_ONLY: parity with old require_ssl, services use Cloud SQL IAM
  connector which handles client certs automatically)
- `kubernetes_namespace` deprecated -> `kubernetes_namespace_v1`
- ksa tfmodule v0.7.0 still uses deprecated `kubernetes_service_account`
  (warning is from the module, fix belongs to stage 4 global-tfmodule-ksa)
- lock files get kubernetes v3.2.1 when declared `>= 2.24.0`

## network / IP layout decisions (earth-base, all envs identical)

- GKE master CIDR: `172.16.0.32/28` (cluster `earth-gke-<env>-eu-1`, autopilot, min 1.35)
- SQL VPC-peering /16 ranges now EXPLICITLY pinned (was auto-allocated; allocator
  once grabbed 172.16.0.0/16 and conflicted with the GKE master range in staging):
  resourcemanager 172.17.0.0, authorization 172.18.0.0, openfga 172.19.0.0,
  iam 172.20.0.0, user 172.21.0.0, content 172.22.0.0, email 172.23.0.0,
  storage 172.24.0.0, billing 172.25.0.0 (all /16, `address` + `prefix_length = 16`)
- redis PSC subnets: authorization 10.0.0.240/29, billingstripe 10.0.0.248/29,
  names `earth-<svc>-s-redis-psc-<e>-eu-1`, scp `earth-redis-scp-<e>-eu-1`
- rationale: 10.x = real VPC subnets, 172.16+ = Google-managed peered ranges

## earth-base env differences (important when copying envs)

- dev: zone `dev.mindful.com.`, per-dev A records from `earth_devs` local
  (loeffel-io, master), identity platform domains include localhost + per-dev
  app/hub domains, certmap hostname = `domains[1]` (wildcard)
- staging: NO earth_devs (removed), single apex A record `staging.mindful.com`,
  identity domains: staging.mindful.com, app.staging..., hub.staging...,
  certmap hostname = `domains[0]` (apex) `# important diff to dev`
- production: apex zone `mindful.com.`, dev/staging NS delegations,
  google site-verification TXTs, webflow (TXT verification, apex A 198.202.211.1,
  www CNAME cdn.webflow.com), gmail MX; NO gateway apex A record (apex is webflow);
  certmap hostname = `domains[1]` (wildcard - services on subdomains);
  identity domains: mindful.com, app.mindful.com, hub.mindful.com
- staging+production kept from dev-copy (deliberate, differs from old production):
  google_firebase_project resource, dnssec on, WAF policies, redis, secret,
  istio manifests etc.

## earth-openfga-base specifics (template for other stage-3 + stage-5 repos)

- production was previously a stub (gsa only, cluster_required=False);
  now fully replicated from staging: AR registry, SQL, namespace, impl gsa/ksa,
  sql iam user, monitoring channel. `cluster_required = False` removed from
  production BUILD.bazel (it touches k8s now).
- staging/production namespace: single `earth-openfga-service`; dev: per-dev
  namespaces `earth-openfga-service-<dev>` from `earth_openfga_service_devs` local
- dev sql databases: one per dev (loeffel-io, master); staging/prod: single
  `earth-openfga-service` db
- monitoring SLO/alert blocks are commented out in the tf (pre-existing)
- SQL sizing applied per README stage-3 table: dev+staging `db-g1-small`
  REGIONAL, production `db-lightweight-2` REGIONAL (tier name mapping:
  db-micro=db-f1-micro, db-small=db-g1-small, db-standard1=db-n1-standard-1,
  lightweight-2=db-lightweight-2).

## db sizing table from README (stage 3 base repos, "sql <prod>; <dev+staging>")

all REGIONAL availability:
- content/billing/user/storage/resourcemanager: prod db-standard1; dev+staging db-micro
- iam/email/authorization: prod db-small; dev+staging db-micro
- openfga: prod lightweight-2; dev+staging db-small (APPLIED)
- website/language/hub/app/authentication: no sql

## gotchas / environment notes

- edit tools require View of exact file first; perl -pi for bulk renames works well
- `terraform` CLI v1.14.8 installed locally; bazel targets run tflint/ls_lint only
- root BUILD.bazel ls_lint references `//deployments/<env>:files` - remove/add
  entries when an env dir is emptied/created (earth-base production was empty for
  a while and broke `bazel build //...`)
- WORKSPACE rules pins differ (v0.19.9 vs v0.19.10) - left alone, tests pass
- old projects: earth-dev-382708, earth-staging-382708, earth-production (no id),
  global-382710, buildkite-382710; base-504915 is the NEW base (from buildkite-382710)
- buildkite repo still has old vars (us-central1, 382710) + all the tf files that
  were deleted from base repo (they moved there); renovate to be REMOVED in new
  buildkite-504915 project
- staging gsa/ksa in buildkite repo use fake `gsa = { account_id/email/name }`
  objects pointing at proto GSAs - naming there partly long-form, will need the
  short-form fix when buildkite is migrated
- GKE+CSM bootstrap ordering: managed service mesh CRDs
  (PeerAuthentication/RequestAuthentication/AuthorizationPolicy/EnvoyFilter)
  appear minutes AFTER gke_hub_feature_membership is ACTIVE; kubernetes_manifest
  needs CRDs at PLAN time -> fresh-project applies need two passes
  (`-target=google_gke_hub_feature_membership.servicemesh_member` first, or re-run)
- istio configmap `istio-asm-managed` in ns `istio-system`; ext-authz on
  `authorization.local:4000`

## buildkite-base specifics

- created from a copy of global-base; renamed: vars.bzl project `buildkite`
  (+ docker_registry var), backend `mindful-buildkite-base-terraform-production-eu-1`,
  gazelle prefix, removed stray `README 2.md`
- WORKSPACE: restored rules_pkg/rules_docker/container_pulls from old base repo
  (buildkite_agent 3.61.0, bazel 8.6.0, bazelisk 1.19.0) - NO renovate pull
  (renovate removed in new buildkite-504915 project)
- container pushes -> `buildkite-504915/buildkite-production-docker-eu-1/...`
- pipeline.yml image still points at OLD digest in new registry path, marked:
  `# 0010_way_back_home: old digest - update after first buildkite-bazel push`
- pipeline service account: `buildkite-base-p`; remote cache bucket
  `mindful-buildkite-base-bazel-production-eu-1`
- docker_push restored: deployments/production/docker_push.sh + sh_binary
  `//deployments/production:docker_push` (agent + bazel pushes only, renovate
  dropped; impersonates `buildkite-base-p@buildkite-504915...`)
- production tf currently only providers (main/vars/versions/backend);
  cluster/nat/agent modules to be added by user (source: old `buildkite` repo
  deployments/modules/*)
- `.bazelversion` 6.6.0 required (6.4.0 -> dyld "missing LC_UUID" failure)
