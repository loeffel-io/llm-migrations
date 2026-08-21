# 0010_way_back_home - migration memory

Working memory for the us-central1 -> europe-west3 migration. Read together
with README.md (rules, stages, db sizing). Keep this file updated after every
repo migration.

## status (as of last session)

| repo | branch | state |
|---|---|---|
| base | main (0010 merged, branch deleted) | DONE incl buildkite split (user committed: buildkite_base_production.tf, global_base_production.tf, multi-project vars.bzl). No pipeline.yml by design (bootstrap) |
| global-base | main (0010 merged, branch deleted) | DONE incl pipeline agent-stack-k8s + v0.9.0 refs + bazel 6.6.0 |
| earth-base | main (0010 merged, branch deleted) | DONE (dev+staging+production, pipeline, v0.9.0, bazel 6.6.0) - NS rrdatas lazy (stage 3) |
| buildkite-base | main (0010 merged, branch deleted) | DONE (cluster/nat/ksa/helm + foreign KSAs for global-base-production, earth-base-dev/staging/production in own tf files, fake-gsa pattern, ns buildkite) |
| buildkite (old repo) | - | legacy us-central1 repo, superseded by buildkite-base, do not touch |
| earth-openfga-base | main (0010 merged, branch deleted) | STAGE 3 DONE + applied by user (repo, buildkite-base KSAs, earth-base WI grants, UI cluster switch, rules v0.19.11) |
| earth-authorization-base | main (0010 merged, branch deleted) | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, ZONAL+MYSQL_8_4, UI cluster switched) |
| earth-iam-base | main (0010 merged, branch deleted) | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, ZONAL+MYSQL_8_4, prod db-g1-small). Needs: user apply + UI cluster switch |
| earth-user-base | main (0010 merged, branch deleted) | STAGE 3 DONE (full recipe, production replicated, proto+internal-proto tf, KSAs, grants). Needs: user apply + UI cluster switch |
| earth-authentication-base | main (0010 merged, branch deleted) | STAGE 3 DONE incl .bazelrc (pushed) + 63-char bucket fix (uncommitted). earth-base earth_auth_base.tf removed (uncommitted there) |
| earth-content-base | main (0010 merged, branch deleted) | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, .bazelrc; prod db-custom-1-3840; bucket lengths ok). Needs: user apply + UI cluster switch |
| earth-resourcemanager-base | main (0010 merged, branch deleted) | STAGE 3 DONE (prod db-custom-1-3840; proto bucket 63-char substr fix) |
| earth-email-base | main (0010 merged, branch deleted) | STAGE 3 DONE (2 services: email+emailmailgun; MAILGUN provider wgebis/mailgun 0.7.7 must stay in versions.tf; prod db-g1-small; internal-proto bucket 63-char fix) |
| earth-billing-base | main (0010 merged, branch deleted) | STAGE 3 DONE (4 units: billing+billingrevenuecat+billingstripe+billingstripe-config; billingstripe has redis -eu-1; prod db-custom-1-3840; revenuecat-proto + billing-internal-proto bucket 63-char fixes) |
| earth-storage-base | main (0010 merged, branch deleted) | STAGE 3 DONE (prod db-custom-1-3840; RAW google_storage_bucket data buckets -> -eu-1 + location US->EU, missed initially) |
| earth-website-base | main (0010 merged, branch deleted) | STAGE 3 DONE (no sql/proto; single service) |
| earth-language-base | main (0010 merged, branch deleted) | STAGE 3 DONE (proto tf w/ hub+app+website readers commented; GSA short-name fix was MISSED in batch, caught by user apply error: account_id >30 chars - fixed service/impl/proto to earth-language-s-<e> pattern) |
| earth-hub-base | main (0010 merged, branch deleted) | STAGE 3 DONE (no sql/proto) |
| earth-app-base | main (0010 merged, branch deleted) | STAGE 3 DONE (earth_app.tf firebase apple/android apps; production ids staging->com.mindful.appx, SHA HASHES COPIED FROM STAGING - user must replace with production signing certs; commented google-play-notifications gsa block left as-is uncommitted-by-user) |
| earth-billingstripe-config | main (0010 merged, branch deleted) | DONE + APPLIED BY USER all envs (full recipe; no gcloud resources of its own - stripe products/prices/portal/webhooks; production main.tf replicated from staging w/ apex domains billingstripe.mindful.com + app.mindful.com; KEEP stripe/stripe + lukasaron/stripe (stripe-third-party) 3.4.1 providers; dev pipeline needs MINDFUL_USER=master + MINDFUL_USER_REVENUECAT_APP_ID=app24d412ed4b as container env in podSpec; its GSA earth-billingstripe-c-<e> is OWNED BY earth-billing-base earth_billingstripe_config.tf -> serviceAccountAdmin grants added THERE (not earth-base); buildkite-base KSA files earth_billingstripe_config_{dev,staging,production}.tf added; stripe resources imported into new state - see stripe import section). Remaining: user UI cluster switch + archive orphaned duplicate stripe products/webhooks |
| everything else | - | STAGE 3 COMPLETE - all 14 base repos + billingstripe-config done. next: stage 4 (gsa+ksa tfmodules already DONE per README) |

## the standard migration recipe (per repo)

1. `git checkout -b chore/loeffel-io/0010` (base/earth-base already had it)
2. Check for AGENTS.md (none found so far in: base, global-base, earth-base, earth-openfga-base)
3. Root `vars.bzl`: region -> `europe-west3`, project ids -> `-504915` suffix
   (production previously had NO number: `earth-production` -> `earth-production-504915`)
4. `terraform.bzl`: impersonated SA uses short env form `env[0:1]`
   (e.g. `earth-openfga-base-p@...`). In earth-openfga-base the
   `trim_gcloud_service_account` param was removed entirely - always trim now.
5. `backend.tf`: bucket gets `-eu-1` suffix (e.g. `mindful-earth-base-terraform-dev-eu-1`)
6. gsa module refs -> `?ref=v0.9.0` (adds `-eu-1` to bucket names internally,
   so `buckets = [...]` lists stay WITHOUT suffix). ksa module -> `?ref=v0.9.0`
   (v0.9.0 fixes kubernetes_service_account -> _v1 deprecation). README bumped
   the target from v0.7.0 to v0.9.0; all migrated repos re-bumped accordingly.
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
12. `build/buildkite/pipeline.yml` -> agent-stack-k8s format (see below),
    cache buckets `-eu-1`, new image digest, KSA serviceAccountName per env
12b. `.bazelrc` in repo root (every bazel WORKSPACE repo):
     `build --action_env=GITHUB_TOKEN` + `test --test_env=GITHUB_TOKEN`
     (added+committed+pushed for openfga/user/authorization/iam/authentication;
     still missing in base/global-base/earth-base/buildkite-base unless user
     added them)
13. `.bazelversion` -> 6.6.0 (WORKSPACE repos) / 8.6.0 (MODULE.bazel repos)
14. `bazel build //...` && `bazel test //...` must pass. NEVER apply/destroy. NEVER commit unless asked.

### pipeline.yml agent-stack-k8s template (canonical example: buildkite-base or earth-base)

```yaml
_templates:
  - &init . ${HOME}/init.sh
  - &bazel-container
    name: "container-0"
    image: "europe-west3-docker.pkg.dev/buildkite-504915/buildkite-production-docker-eu-1/buildkite-bazel@sha256:014c9027d239a4e4de7e5d4354f3fd020c2b203dc36838d6999808711277455b"
    resources: {requests: {cpu: "1", memory: "2Gi"}, limits: {cpu: "1.75", memory: "3Gi"}}
  - &k8s-agent-stack-<env>
    plugins:
      - kubernetes:
          podSpec:
            serviceAccountName: "<repo>-<env>"   # KSA name, full env form
            containers: [*bazel-container]
steps:  # step: `!!merge <<: *k8s-agent-stack-<env>` + label + command list
```
Groups: Global (gazelle_fix_diff+test+build) -> Build (tf init+plan) ->
Deployment dev/staging `if: build.branch == "main"`, production
`if: build.tag != null`. Old format to replace: EmbarkStudios/k8s#v1.3.1 with
secret-name/mount-secret keys.

## cross-repo references that could not be migrated yet

Marked with comment: `# 0010_way_back_home: stage 3 - uncomment after the owning earth-*-base repo created this gsa`

- global-base/deployments/production/global_proto.tf: 18 commented
  artifact-registry reader grants for earth service/proto GSAs
- global-base/deployments/production/global_ui.tf: 9 commented reader grants
- earth-base `subdomains` NS record rrdatas: real values only known after
  the stage-3 child zone exists (gcloud assigns ns-cloud-<letter>{1..4} set).
  SYNCED per README (incl post-apex-fix recreated production zones):
  user (c/d/a), authorization (a/d/e), iam (a/d/a), authentication (a/c/d),
  content (c/a/c), resourcemanager (c/a/a), email (d/d/a),
  emailmailgun (a/a/e), storage (c/d/c), language (a/d/d), billing (d/c/e),
  billingstripe (c/c/e), billingrevenuecat (a/c/c), hub (d/d/a),
  app (a/a/d) - ALL synced in earth-base main.tf (validate green all envs,
  uncommitted). Website has NO ns zone (direct A record, per README).
  Openfga has no zone (no dns in that repo). NS sync COMPLETE.

## provider 7.x breaking changes hit so far

- `google_sql_database_instance.settings.ip_configuration.require_ssl` removed
  -> `ssl_mode = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"` (keep this mode, NOT
  ENCRYPTED_ONLY: parity with old require_ssl, services use Cloud SQL IAM
  connector which handles client certs automatically)
- `kubernetes_namespace` deprecated -> `kubernetes_namespace_v1`
- ksa tfmodule v0.9.0 fixed the `kubernetes_service_account` deprecation
  (v0.7.0 warned); no warnings left anywhere
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
  REGIONAL, production `db-custom-2-3840` REGIONAL.

## db sizing table from README (stage 3 base repos, "sql <prod>; <dev+staging>")

ALL SQL: availability_type ZONAL (user decision, replaced earlier REGIONAL
plan) + database_version MYSQL_8_4 (in README now) + edition = "ENTERPRISE"
(explicit, user added to all previously-done instances; include in every new
sql instance settings block).
require_ssl=true legacy -> ssl_mode TRUSTED_CLIENT_CERTIFICATE_REQUIRED;
pre-existing ENCRYPTED_ONLY (authorization) stays ENCRYPTED_ONLY. TIER VALUE MAPPING (README): db-lightweight-2 ->
`db-custom-2-3840`, db-standard-1 -> `db-custom-1-3840`; db-micro ->
`db-f1-micro`, db-small -> `db-g1-small` (real tier names, no mapping needed)
- content/billing/user/storage/resourcemanager: prod db-custom-1-3840; dev+staging db-f1-micro
  (user APPLIED incl ZONAL+8.4+ENTERPRISE)
- iam/email/authorization: prod db-g1-small; dev+staging db-f1-micro
  (iam APPLIED incl ZONAL+8.4)
- openfga: prod db-custom-2-3840; dev+staging db-g1-small (APPLIED incl ZONAL+8.4)
- authorization: APPLIED incl ZONAL+8.4 (prod db-g1-small)
- website/language/hub/app/authentication: no sql

## gotchas / environment notes

- edit tools require View of exact file first; perl -pi for bulk renames works well
- NEVER use raw `terraform` CLI - use the repo wrappers via zsh aliases:
  `td`/`ts`/`tp` = `bazel run //deployments/{dev,staging,production}:terraform`
  (e.g. `zsh -ic 'tp -- validate'` from the repo root); bazel targets run
  tflint/ls_lint only
- root BUILD.bazel ls_lint references `//deployments/<env>:files` - remove/add
  entries when an env dir is emptied/created (earth-base production was empty for
  a while and broke `bazel build //...`)
- WORKSPACE rules pin: ALL workspace repos must use
  `com_github_mindful_hq_rules` tag v0.19.14 (bumped from v0.19.11 across all
  8 migrated repos, committed as "chore: update build rules to v0.19.14";
  earth-base was already bumped+committed by user)
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
- OLD vs NEW mesh setup diff (analyzed, explains metadata flakiness):
  old us-central1 used terraform-google-modules/kubernetes-engine//
  modules/asm v29.0.0 (in global-tfmodule-google-cloud-gke-cluster
  history, commit before 6c7729d) with enable_cni=true -> created
  1) ControlPlaneRevision `asm-managed` (type managed_service, channel
  regular) = PINNED istiod-based managed control plane, 2) asm-options
  ConfigMap (ASM_OPTS CNI=on), 3) mesh feature WITHOUT management attr.
  New earth-base uses only feature_membership MANAGEMENT_AUTOMATIC ->
  Google provisioned the TD-based implementation on the fresh clusters
  (slow xDS propagation, strict MeshConfig validation). Metadata 502/
  503/refused = TD push gaps while envoy proxies 169.254.169.254.
  DECISION: keep excludeOutboundIPRanges metadata bypass (Google-
  recommended, node-local traffic); do NOT add a CPR (conflicts with
  MANAGEMENT_AUTOMATIC, legacy provisioning path)
- istio configmap `istio-asm-managed` in ns `istio-system`; ext-authz on
  `authorization.local:4000`

## buildkite-base specifics

- created from a copy of global-base; renamed: vars.bzl project `buildkite`
  (+ docker_registry var), backend `mindful-buildkite-base-terraform-production-eu-1`,
  gazelle prefix, removed stray `README 2.md`
- WORKSPACE: restored rules_pkg/rules_docker/container_pulls from old base repo
  (buildkite_agent 3.61.0, bazel image 6.6.0 digest 5e8a214..., bazelisk 1.19.0)
  - NO renovate pull (renovate removed in new buildkite-504915 project)
- container pushes -> `buildkite-504915/buildkite-production-docker-eu-1/...`
- pipeline.yml now uses NEW buildkite-bazel digest sha256:014c9027d239...
  (user pushed); serviceAccountName `buildkite-base-production` (KSA full-form);
  remote cache bucket `mindful-buildkite-base-bazel-production-eu-1`
- docker_push restored: deployments/production/docker_push.sh + sh_binary
  `//deployments/production:docker_push` (agent + bazel pushes only, renovate
  dropped; impersonates `buildkite-base-p@buildkite-504915...`)
- production tf complete: standard GKE cluster buildkite-gke-production-eu-1
  (c2d-highcpu-4 pool, workload identity, gke backup addon), nat
  buildkite-nat-production-eu, network, ksa module (fake gsa object referencing
  base-repo-created `buildkite-base-p` GSA), agent secrets from secret manager
  (created in base repo), helm_release agent-stack-k8s 0.47.0 ns `buildkite`
- helm provider pinned exactly 3.1.1 (hashicorp/terraform-provider-helm#1798)
- `.bazelversion` 6.6.0 required (6.4.0 -> dyld "missing LC_UUID" failure)

## stage 1+2 production-readiness audit (post user additions)

- base: user added buildkite_base_production.tf (project services, gsa
  buildkite-base-p, AR `buildkite-production-docker-eu-1`, agent secrets:
  token/ssh-key/github-token + accessor grants), global_base_production.tf,
  reworked vars.bzl (separate global/buildkite/earth project vars). SA
  impersonated by base BUILD.bazel is `base-production@base-504915` (FULL env,
  manually-created bootstrap SA - not module-managed, left as-is)
- buildkite-base: user added cluster (buildkite-gke-production-eu-1, standard
  cluster + c2d-highcpu-4 node pool, workload identity), nat
  (buildkite-nat-production-eu), ksa (name `buildkite-base-production`
  full-form, matches pipeline serviceAccountName), agent secrets wiring,
  helm agent-stack-k8s v0.47.0 (namespace `buildkite`, create_namespace).
  helm provider pinned 3.1.1. kubernetes provider was UNDECLARED -> added.
  KSAs for other repos (global-base-production, earth-base-dev/staging/
  production) added: earth_base_{dev,staging,production}.tf +
  global_base_production.tf, ksa module v0.9.0 fake-gsa pattern, KSA names
  full-form (match pipeline serviceAccountName), GSA emails short-form
  (earth-base-d/s/p@earth-<env>-504915, global-base-p@global-504915),
  foreign project ids centralized in deployments/production/locals.tf
  (gcloud_global_project/_production_project_id, gcloud_earth_project/
  _dev/_staging/_production_project_id) - locals not vars, because the shared
  terraform_binary only passes the 5 standard TF_VARs. locals.tf listed in
  BUILD.bazel terraform_files. Future stage-3 repo KSAs (earth-openfga-base-*
  etc.) go in new per-repo tf files reusing these locals - still lazy
- pipelines converted from EmbarkStudios/k8s#v1.3.1 (old stack) to
  agent-stack-k8s `kubernetes` plugin format (podSpec/serviceAccountName/
  containers, template `&bazel-container`): global-base + earth-base done;
  buildkite-base was already new-format (user). New image digest for
  buildkite-bazel: sha256:014c9027d239... in
  buildkite-504915/buildkite-production-docker-eu-1. cache buckets now -eu-1
- module refs bumped v0.7.0 -> v0.9.0 in base(5), global-base(6),
  earth-base(45), earth-openfga-base(9 incl ksa)
- all 9 tf dirs validate clean (no deprecation warnings anymore), fmt clean,
  bazel build+test green in all 5 repos

## bazel version policy (README `## bazel version`)

- WORKSPACE repos: `.bazelversion` 6.6.0; bazel base image digest
  sha256:5e8a214baa9ab294531695663df472d2200f2bb1a150693e81f70f64d24ae4ce
- MODULE.bazel repos: `.bazelversion` 8.6.0; image digest
  sha256:8a769263e86729929bc1f389d3fa7e5e915c2788fe8c1fa6f2e545e4e094f23d
- all stage 1+2 repos (+ earth-openfga-base) are WORKSPACE repos -> 6.6.0
  applied (global-base/earth-base/earth-openfga-base were on 6.4.0)
- buildkite-base WORKSPACE container_pull "bazel" pins 5e8a214 (6.6.0),
  buildkite-bazel image push tag 6.6.0; both digests kept as comment above
  the pull for the future module-repo image
- base repo has NO pipeline.yml by design (manual bootstrap, chicken-egg)
- earth-openfga-base pipeline migrated to agent-stack-k8s format too
  (KSAs earth-openfga-base-dev/staging/production, cache buckets
  mindful-earth-openfga-base-bazel-<env>-eu-1, new image digest 014c9027...)
- pipeline cache bucket names = the gsa module `buckets` entry + `-eu-1`
  (module appends suffix); openfga pipeline buckets come from earth-base's
  earth_openfga_base.tf (`-openfga-base-bazel-<env>`), NOT the service bucket
- leftover EmbarkStudios URL in buildkite-base main.tf is a docs comment
  for the agent secret workaround - intentional

## cross-project workload identity grants (bootstrap ordering!)

- ksa module writes a `roles/iam.workloadIdentityUser` binding ONTO the target
  GSA -> the applying SA needs get/setIamPolicy on that foreign GSA
- fix: base repo (owner of earth-base-d/s/p + global-base-p GSAs) grants
  SA-level `roles/iam.serviceAccountAdmin` on each of those GSAs to
  `buildkite-base-p@buildkite-504915` (in base/deployments/production/
  earth_base_{dev,staging,production}.tf + global_base_production.tf,
  comment-free per style rule)
- the grant repo must be APPLIED before buildkite-base, otherwise the ksa
  module 403s on `iam.serviceAccounts.getIamPolicy` for the foreign GSA -
  the openfga 403s were exactly this (earth-base grants not yet applied),
  NOT a missing-grant-in-base problem; base does NOT need every GSA
- apply order on fresh bootstrap: base (creates GSAs + grants) ->
  buildkite-base (creates KSAs + WI bindings) -> global-base/earth-base
  pipelines can then run in the cluster
- same pattern will be needed for every stage-3 earth-*-base repo KSA:
  the repo that owns the GSA adds the serviceAccountAdmin grant for
  buildkite-base-p; the KSA file goes in buildkite-base

## buildkite cluster assignment (manual UI step per pipeline!)

- symptom: job runs on pod `buildkite-agent-<rs-hash>-<suffix>` (Deployment
  pattern = OLD chart-based agent) and fails cloning
  `buildkite-plugins/kubernetes-buildkite-plugin` via https (the `kubernetes`
  plugin is VIRTUAL - only the agent-stack-k8s controller understands it;
  classic agents try to git-clone it as a real plugin and die)
- root cause: the buildkite PIPELINE was still assigned to the old cluster/
  agents in the buildkite UI. NOT a queue problem - we intentionally use the
  DEFAULT queue everywhere (a queue-tag fix was tried and reverted)
- fix: after migrating a repo's pipeline.yml, MANUALLY switch the pipeline to
  the new cluster agent in the buildkite UI (pipeline cluster setting).
  no code change needed. done for global-base; required for EVERY migrated repo
- helm release keeps `# tags = ["queue=kubernetes"]` commented out - leave it

## stage 3 per-repo checklist (established with earth-openfga-base, refined via authorization/iam/user)

0. check `git status` first - user often pre-applies parts on main
   (e.g. ZONAL/8.4 for user-base); check `rg 'edition|ZONAL|MYSQL'` before editing
1. repo itself: full recipe + these stage-3 specials:
   - sql settings: tier per README table, `edition = "ENTERPRISE"`,
     `availability_type = "ZONAL"`, `database_version = "MYSQL_8_4"`
   - GSA short names incl proto/impl (watch long-form leftovers - user-base
     AND language-base had `earth-<svc>-service-<env>` style; language slipped
     through the batch because the check was skipped -> ALWAYS run
     `rg 'account_id' | rg -v 'substr'` per repo; GCP limit: account_id
     6-30 chars, `earth-language-service-production` = 33 = apply error)
   - production is usually a GSA stub + proto tf -> replicate service tf +
     main.tf from staging (_staging -> _production), fix production tier
   - PRODUCTION DOMAINS: replace `.${var.env}.mindful.com` -> `.mindful.com`
     (production zone is apex; `<svc>.production.mindful.com` does NOT exist;
     cert would try wrong domain). Fixed retroactively in ALL 16 production
     service files. Also check hardcoded env domains (storage CORS had
     app/hub.staging.mindful.com + localhost -> app/hub.mindful.com)
   - proto tf gotchas: stale `_staging` module NAME inside production file
     (authorization, iam, user all had it), AR repo `-eu-1`, foreign
     service reader grants (hub/app/...) -> comment with stage-3 marker until
     owning repo migrated
   - GCS BUCKET NAME 63-CHAR LIMIT: module appends `-eu-1`, so check
     `len("mindful-<project>-<name>-bazel-<env>") + 5 <= 63`. If over, use
     `${substr(var.env, 0, 1)}` for THAT bucket only with comment
     `# 63 char bucket name limit` (accepted inconsistency, no big migration).
     Hit: authentication-service-proto production (64). Exactly 63 (ok):
     user-service-internal-proto, authorization-service-proto production.
     `authentication` (14 chars) is the longest service name - most at risk
   - deprecations: kubernetes_namespace/secret -> _v1; data kubernetes_service
     -> _v1 (only repos with ACTIVE monitoring SLOs, e.g. user-base)
   - RAW `google_storage_bucket` RESOURCES (outside gsa module): need manual
     `-eu-1` suffix AND `location` US -> EU (storage-base data bucket was the
     only one in stage 3; module-created buckets get both automatically)
   - remove `cluster_required = False` from production BUILD.bazel
   - pipeline.yml: generate from earth-authorization-base pipeline via
     name replace
2. buildkite-base: add `earth_<svc>_base_{dev,staging,production}.tf` KSA files
   (fake-gsa pattern, locals from locals.tf, ns `buildkite`, KSA name full-form
   `earth-<svc>-base-<env>` == pipeline serviceAccountName, GSA email short
   `earth-<svc>-base-<e>@earth-<env>-504915`); add files to BUILD.bazel
3. earth-base: append `google_service_account_iam_member` grant
   (`roles/iam.serviceAccountAdmin` for
   `buildkite-base-p@buildkite-504915.iam.gserviceaccount.com`, SA-level,
   NO comments - user wants these grant resources comment-free) to each
   env's `earth_<svc>_base.tf` - earth-base has no buildkite vars, member inline
4. remind user: manual buildkite UI cluster switch for the pipeline
5. apply order: earth-base (grants) -> buildkite-base (KSAs) -> repo pipeline
- done for openfga: buildkite-base earth_openfga_base_{dev,staging,production}.tf,
  earth-base earth_openfga_base.tf grants (all envs), all validate/bazel green

## we go production (README section)

- env promotion model: staging config is based on dev, production is based on
  staging - keep that direction when copying envs
- production has NEVER been deployed before this migration - expect first-run
  issues (missing APIs, bootstrap ordering, unpushed images)
- production deploys trigger on GIT TAGS (`if: build.tag != null` in
  pipeline.yml deployment-production groups - already in all migrated
  pipelines); dev+staging deploy on branch main
- rules repo v0.19.14 mandatory for WORKSPACE repos (required for the
  stage-3 buildkite/ksa flow) - bumped in all stage 1+2 repos, keep for
  every stage-3+ repo

## style: no explanatory comments on WI grant resources

- user removed/renamed all `# 0010_way_back_home: allows...` comments on the
  serviceAccountAdmin grant resources - DO NOT add explanatory comments to
  these (or similar) resources going forward; resource names are descriptive
  enough. The `stage 3 - uncomment` markers on commented-out RESOURCES in
  global-base remain (they track work, not explanation)
- user also removed the agents/queue block from earth-base pipeline (default
  queue is used everywhere); removed leftover queue block from
  earth-openfga-base pipeline too

## earth-authorization-base specifics

- has redis cluster (REDIS_SHARED_CORE_NANO, IAM auth) -> name got -eu-1;
  gateway tls via tls provider (self-signed, KEEP tls in versions.tf);
  pubsub subscription to user-service user-events-v1 (data lookups on
  earth-user-service topics - created by earth-user-base? no: created in
  earth-user-base/-service, exists per env at apply time, dev/staging use
  per-dev topics); kubernetes_secret -> _v1, kubernetes_namespace -> _v1
- sql: db-f1-micro dev+staging, db-g1-small production, ZONAL, MYSQL_8_4
- production was 19-line stub + proto tf; replicated from staging
  (_staging -> _production) + fixed proto tf: dedup resource names
  (old file had duplicate production reader names), repo id -eu-1,
  hub-service reader grants commented with stage-3 marker (earth-hub-base
  not migrated), proto GSA repoAdmin kept
- production BUILD.bazel: cluster_required=False removed
- ssl_mode here is pre-existing "ENCRYPTED_ONLY" (unlike openfga's
  TRUSTED_CLIENT_CERTIFICATE_REQUIRED) - left as-is, pre-existing choice

## stage 3 repo shape notes (iam == authorization minus redis/pubsub)

- earth-iam-base: no redis, no pubsub; has tls gateway certs, dns zone
  iam.<env>.mindful.com, certmap entry hostname domains[1], per-dev namespaces
  in dev, single ns staging/prod; production was 18-line gsa stub + proto tf
  with STALE module name (gsa_..._proto_staging in production file!) - fixed
  during replication; same stale-name pattern existed in authorization
- pipeline.yml can be generated: copy authorization pipeline, replace repo name
  (perl/python string replace "earth-authorization-base" -> "earth-<svc>-base")

## earth-user-base specifics

- OWNS the user-events-v1 pubsub topics (+dead-letter) that authorization
  subscribes to; has ACTIVE monitoring SLOs/alerts (not commented like
  openfga/authorization) -> `data "kubernetes_service"` needed _v1 migration
  (kubernetes_service_v1); no redis; sql had NO ssl config at all
  (pre-existing, left without ssl_mode)
- GSA short-name fixes: service/impl were long-form (`earth-user-service-dev`)
  -> `earth-user-s-d` + `-i`; proto was `earth-user-service-proto-p` ->
  `earth-user-s-p-p` (matches global-base commented readers!); internal proto
  already short (`earth-user-s-i-p-p`) but its BUCKET had a bug: suffix was
  substr(env,0,1) -> fixed to full env
- production proto tf had stale `_staging` module name + hub/app service
  reader grants -> commented with stage-3 markers (hub-base + app-base not
  migrated); dev+staging repos already had MYSQL_8_4+ZONAL on main (user)

## earth-authentication-base specifics

- 0010 branch is based on `chore/loeffel-io/auth-to-authentication` (3 commits
  ahead of main) - the in-flight auth->authentication rename; merge/PR flow
  must land that branch first or together
- rename branch kept BOTH earth_auth_* (legacy) and earth_authentication_*
  files; legacy auth files git-rm'd for the new projects (new projects get
  authentication-only resources; earth-base subdomains map only delegates
  `authentication`); earth-base legacy earth_auth_base.tf files git-rm'd
  (all envs + BUILD entries, uncommitted in earth-base)
- terraform.bzl SA renamed earth-auth-base-<env> ->
  earth-authentication-base-<e>; backend buckets renamed auth ->
  authentication (+-eu-1); pipeline generated with
  earth-authentication-base-<env> KSAs
- no sql, no redis; has pubsub subscription to user-events-v1, tls gateway
  certs, dns zone authentication.<env>.mindful.com; proto tf had hub+app
  reader grants -> commented with stage-3 markers; authentication GSA
  account_ids were already short-form (from the rename branch)

## session addendum (latest)

- earth-base uncommitted work now includes: git-rm earth_auth_base.tf (3 envs
  + BUILD entries), NS letters for user/authorization/iam, WI grants for
  openfga/authorization/iam/user/authentication KSAs
- buildkite-base uncommitted: KSA files for authorization/iam/user/
  authentication (+ BUILD entries)
- committed+pushed so far on chore/loeffel-io/0010: rules v0.19.14 bump
  (7 repos + earth-base by user), .bazelrc GITHUB_TOKEN (5 stage-3 repos)
- earth-authentication-base has UNCOMMITTED changes on top of the pushed
  .bazelrc commit: the whole 0010 migration + 63-char bucket fix
- stage 3 COMPLETE (all 14 repos)
- README stage-3 lines now carry per-repo runtime data from user: mysql ips
  (all envs 172.17.0.x - dev/staging/prod same ip, per-service distinct)
  and ns zone letters - keep syncing NS letters into earth-base subdomains
  when user adds them

## multi-service repo notes (email/billing) + batch gotchas

- earth-email-base: services email + emailmailgun; emailmailgun uses the
  `wgebis/mailgun` 0.7.7 provider -> NEVER drop it from versions.tf (overwriting
  versions.tf wholesale broke init; always MERGE provider blocks)
- earth-billing-base: units billing / billingrevenuecat (+ google-play RTDN
  gsa) / billingstripe (has redis cluster -eu-1) / billingstripe-config
  (secrets only, gsa has terraform bucket too)
- 63-char bucket substr fixes applied: resourcemanager-service-proto (65),
  email-service-internal-proto (64), billing-service-internal-proto (66),
  billingrevenuecat-service-proto (67); billingstripe-service-proto exactly 63 ok
- storage/email/billing had ssl_mode ENCRYPTED_ONLY pre-existing in dev
  (kept? NO - they were require_ssl->ENCRYPTED_ONLY already on main; only
  resourcemanager had require_ssl=true -> TRUSTED_CLIENT_CERTIFICATE_REQUIRED)
- shell heredoc gotcha: this bash strips `\$` inside single-quoted heredocs -
  build python regexes with re.escape("${var...}") instead of hand-escaping
- batch glob gotcha: `earth-*-base` globs match NOT-YET-MIGRATED repos
  (earth-language-base got touched, reverted via git checkout) - always
  list repos explicitly
- env vars.bzl gotcha: project ids are CONCATENATED
  (`gcloud_project + "-dev-382708"`) - perl patterns like `earth-dev-382708`
  silently miss; always `cat deployments/*/vars.bzl` to verify after replace
  (hit in earth-billingstripe-config, caught by user 403 with old project id)

## no-sql repo batch notes (website/language/hub/app)

- all four: no sql, no redis; tls gateway certs + kubernetes -> keep tls +
  kubernetes + google-beta in versions.tf (google-beta needed: firebase apps
  in app-base use it; hub/website/language use certmap/beta features)
- earth-app-base extra file earth_app.tf (firebase apple+android apps):
  dev = per-dev bundle ids com.mindful.dev.appx.<dev>, staging =
  com.mindful.staging.appx, production replicated -> com.mindful.appx with
  STAGING SHA1/SHA256 HASHES (unknown production signing certs - USER TODO);
  old production file was just a TODO comment. app-base dev also has an
  uncommitted-by-user commented google-play-developer-notifications gsa block
- language proto readers (hub/app/website) commented with stage-3 markers -
  can be uncommented as soon as this batch is APPLIED (owning repos now exist
  in code; grants activate after their earth-base/buildkite-base applies)
- pipeline serviceAccountNames: earth-<svc>-base-<env> as usual

## stripe state migration (earth-billingstripe-config) - import playbook

The new -eu-1 terraform state was EMPTY but the stripe accounts already had
all resources -> every apply 409'd or created DUPLICATES. Stripe accounts are
per env/workspace: dev loeffel-io acct_1T0dom3PMKBmrlYq, dev master
acct_1T0dp93wMyiTnEdS, staging acct_1T0eN241t1X8B9kJ. dev uses per-user
workspaces (MINDFUL_USER define selects backend prefix + secret).

Key learnings:
- `destroy` on stripe_price = ARCHIVE in stripe (not delete); lookup_key
  conflicts (400 "already uses that lookup key") mean the price exists ->
  import, never recreate
- ordering trap: if products got newly created (duplicates) but prices are
  imported from the OLD products, plan shows `product ... forces replacement`
  -> must `state rm` the duplicate products and import the OLD product ids
  (find them via the price detail page in the stripe dashboard) BEFORE/WITH
  importing the prices
- webhooks: applies created duplicate webhook endpoints -> `state rm` the
  new ones from state, import the old ids, then DELETE the duplicates
  manually in the stripe dashboard (state rm leaves them alive in stripe)
- portal config ids (bpc_...): dashboard Settings -> Billing -> Customer
  portal; dev master bpc_1TWAuP3wMyiTnEdSk8YKyWUs
- old webhook ids imported: dev loeffel-io revenuecat
  we_1TVBgm3PMKBmrlYqe22lBNqg / billingstripe we_1TVBgn3PMKBmrlYqhCgg2Bz9;
  dev master revenuecat we_1TVRpP3wMyiTnEdSNAKGWuYh / billingstripe
  we_1TVRpO3wMyiTnEdSo68o7IVu; staging revenuecat
  we_1TVSRC41t1X8B9kJ0pfYAxKK / billingstripe we_1TVSRD41t1X8B9kJDhJk8N0D
- command shape: `td|ts -- state rm <addr>` + `td|ts -- import <addr> <id>`
  (td dev needs correct MINDFUL_USER workspace); production not touched yet
  (stripe live account - expect the same import dance on first tp apply)
- leftover duplicates to archive/delete manually in stripe: products
  prod_V4Ma*/prod_V4Nb* (per account) + the duplicate we_1U4* webhooks

## import playbook (google 409s, general)

- 409 "already exists" for topics/GSAs in the PRE-EXISTING side projects
  (earth-dev-revenuecat, earth-staging-revenuecat - NOT migrated, no -504915)
  -> import: topics `projects/<proj>/topics/<name>`, GSAs
  `projects/<proj>/serviceAccounts/<email>`, for_each keys quoted:
  `'resource.name["loeffel-io"]'`

## TEMPORARY dev DNS fallback to us-central1 (REVERT in 2-3 days!)

- team blocked since migration -> ALL dev per-dev service A records
  (loeffel-io.<svc>.dev.mindful.com etc.) temporarily point to the OLD
  us-central1 LB `35.244.133.111` instead of the new gateway address
- marker comment `# 0010_way_back_home: tmp us-central1 fallback, revert
  after migration` above the commented-out original rrdatas line
- 14 A records in 11 repos (deployments/dev): content, user, authorization,
  iam, authentication, resourcemanager, email + emailmailgun, storage,
  language, billing + billingstripe + billingrevenuecat, hub
- PLUS storage cdn.storage.dev.mindful.com -> old cdn LB `34.111.1.218`
  (the cdn has its OWN global address, NOT the 35.244.133.111 gateway)
- NOT touched: website + app (per user), staging/production
- REVERT: rg the marker, restore the data-source line, delete IP + comments

## stage 1-3 production-readiness audit (pre stage 4)

- all 19 repos: branch chore/loeffel-io/0010, clean, pushed (ahead=0)
- consistent everywhere: europe-west3 + -504915 (no 382708/382710/us-central1
  leftovers), bazel 6.6.0, rules v0.19.14, .bazelrc GITHUB_TOKEN, gsa/ksa
  v0.9.0, google >= 7.43.0, tflint 0.39.0, agent-stack-k8s pipelines with
  new image digest + -eu-1 cache buckets + tag-gated production
- fixed during audit: billingstripe-config staging+production .tflint.hcl
  were 0.25.0 (dev was 0.26.0 -> only that one got replaced earlier)
- UNCOMMENTED all 78 stage-3 marker reader grants (13 files: 9 earth-*
  production proto tfs + global-base global_proto.tf/global_ui.tf) - all
  owning GSAs now exist. NO markers left anywhere. Validate+fmt+bazel green
- cross-repo wiring verified: buildkite-base 16x3 KSA files (14 base repos +
  earth_base + billingstripe_config), earth-base 14 grant files per env,
  billingstripe-config grants in earth-billing-base (3 envs)
- earth-base NS: all zones synced (60/60/68 ns-cloud lines dev/staging/prod)
- no production.mindful.com leftovers anywhere
- user TODOs before/during stage 4: apply the uncommented reader grants
  (global-base + 9 earth production repos), app-base production SHA
  hashes still staging copies, tmp dev DNS fallback must be reverted in
  2-3 days, archive stripe duplicates

## stage 4 (in progress -> DONE code-side)

All 21 stage-4 repos (rules, 16 proto/internal-proto, global-proto/ui/
generics, dart-registry) on chore/loeffel-io/0010, migrated:

- MODULE repos: .bazelversion 8.6.0, pipeline image digest 8a769263...;
  rules is now ALSO a MODULE repo on main (8.6.0 + .bazelrc existed) -
  NOT 6.6.0 as the old checkout suggested
- PULL FIRST gotcha: global-ui was 60 behind, rules 102 behind (0010 branch
  was cut from stale maintenance/loeffel-io/bazel-workspace) -> re-branched
  from fresh origin/main and re-applied. ALWAYS git fetch + check behind
  before branching stage 5 repos!
- pipelines: EmbarkStudios -> agent-stack-k8s (production-only pipelines,
  single serviceAccountName <repo>-production), cache buckets -eu-1;
  63-char bucket substr names reflected in pipeline env urls
  (...-bazel-p-eu-1 for authentication/resourcemanager/email-internal/
  billingrevenuecat/billing-internal); dart-registry pipeline has NO
  serviceAccountName (no KSA on main) and NO remote cache
- npm repos: vars.bzl europe-west3 + earth-production-504915/global-504915;
  .npmrc/package.json/pnpm-lock.yaml registry urls ->
  europe-west3-npm.pkg.dev/<new-project>/<repo>-production-eu-1;
  npm/BUILD.bazel registries + gcloud_service_account short form
  (earth-<svc>-s-p-p@..., global-proto-p@..., global-ui-p@...)
- npmrc rules_js bug workaround (USER INFO): `bazel run
  //deployments/production/npm:npmrc` then `bazel clean --expunge`, then
  rebuild works. Auth alone is NOT enough for the 10 earth npm proto repos:
  builds still 403 on global-proto-production-eu-1 tarball - EXPECTED until
  user applies the new grants + global-proto is published to the new AR
  (chicken-egg; global-proto/global-ui/generics/dart-registry/rules and the
  5 github-only internal-proto repos all build+test PASS locally)
- dart-registry: rules git_override bumped v0.20.36 -> v0.20.62 (sh_test
  native removal in bazel 8.6), .bazelversion 8.6.0 added (was missing);
  e2e test needs GH_TOKEN env (`gh auth token`)
- cross-repo additions (all validate green): 6 missing AR -eu-1 suffixes
  fixed (billingstripe/email/language/billing/resourcemanager/storage
  production proto AR); 20 serviceAccountAdmin grants appended in owning
  repos (16 earth proto/internal-proto + rules/global_proto/global_ui/
  global_generics in global-base); 20 KSA files + BUILD entries in
  buildkite-base (KSA name <repo>-production, gsa short names, earth vs
  global project locals)
- global-renovate-config: nothing to migrate (no bazel, no region refs);
  renovate is being removed in the new buildkite project anyway
- apply order for stage 4: earth-*-base tp + global-base tp (grants+AR) ->
  buildkite-base tp (KSAs) -> publish global-proto to new AR (tag) ->
  earth npm proto repos build; then buildkite UI cluster switch per pipeline

## stage 4 applies (DONE by agent, user-authorized)

- applied production via `tp -- apply -auto-approve`: 9 earth base repos
  (user/authorization/iam/authentication/content/resourcemanager/email/
  storage/language/billing), global-base, buildkite-base (40 KSA resources)
- AR rename to -eu-1 = destroy+create (the "2 destroyed" per repo were the
  old non-suffixed production proto ARs; billing had 4)
- global-base showed "no changes": user had already applied it (grants were
  in state); NOT the cache bug that time
- old bug workaround when apply picks up stale files: `bazel clean` +
  `tp -- init` then re-apply (bazel run copies terraform_files from cache)
- `tp -- plan -detailed-exitcode` exit codes do NOT propagate through the
  bazel wrapper - grep "No changes" instead
- final state: all 12 repos plan clean. earth npm proto repo builds should
  now work after global-proto is published to the new AR (tag release)

## pipeline image digest correction (stage 4)

- the two digests in README `## bazel version` (5e8a214=6.6.0, 8a769263=8.6.0)
  are the UPSTREAM gcr.io/bazel-public/bazel BASE image digests - they are
  what goes into buildkite-base WORKSPACE container_pull, NOT into pipelines
- pipelines must pin the digest of the PUSHED buildkite-bazel image
  (base + home/ssh tars). global-proto v2.24.0 release failed with
  image-pull error because stage-4 pipelines pinned the base digest 8a769263
- pushed buildkite-bazel image digests (pipelines pin THESE):
  6.6.0 tag = sha256:014c9027d239a4e4de7e5d4354f3fd020c2b203dc36838d6999808711277455b
  8.6.0 tag = sha256:6a226aebce87b34d7a99094bb37f6b3fe6a260c75adf9d4401aaffeaec24e0f5
  (user pushed + verified in AR)
- all 21 stage-4 MODULE pipelines now pin 6a226aeb; the 18 WORKSPACE
  base-repo pipelines keep 014c9027
- global-proto 2.24.0 published to new AR MANUALLY by agent (local
  `bazel run //deployments/production/npm:global_proto.publish` with
  BUILDKITE_TAG=v2.24.0 after npmrc auth + clean --expunge) - npm proto
  repos bumped to ^2.24.0 with regenerated pnpm locks (integrity
  sha512-N1dx3Gd8...); the failed buildkite release can be re-run later
  with the fixed pipeline for cache-bucket parity, package already usable

## stage 4 FINAL (all green)

- global-proto v2.25.0 released via fixed pipeline (v2.24.0 tag broken -
  released while pipeline still had wrong image digest; superseded)
- all 11 npm proto repos bumped to ^2.25.0, locks regenerated, build+test
  PASS everywhere (21/21 stage-4 repos green: 11 npm protos, 5 github-only,
  global-proto/ui/generics, dart-registry, rules)
- npmrc hint (user): all proto repos share $HOME/.npmrc - ONE
  `bazel run //deployments/production/npm:npmrc` + ONE
  `bazel clean --expunge` (only in repos with a CACHED failed fetch)
  suffices; fresh repos just build after auth
- global-proto is DONE on main (merged PR #55 + digest bump commit);
  remaining stage-4 repos have uncommitted 0010 changes for user review
- user TODOs: commit+push+PR the 20 dirty repos, buildkite UI cluster
  switch per stage-4 pipeline, then re-tag releases as needed

## proto releases (stage 4 -> production ready)

- all 16 earth proto/internal-proto repos: 0010 committed, merged to main,
  pushed, tagged + pushed. 15x v1.0.0 (were <1.0.0); earth-email-service-proto
  v1.12.0 (was v1.11.0). Buildkite releases trigger on these tags
- PRECONDITION for green releases: buildkite UI cluster switch per pipeline
  (old chart agents fail on the virtual kubernetes plugin) - if a tag build
  fails, switch cluster + retry the build, no re-tag needed
- these versions are what stage-5 service repos should consume
  (npm @<repo>-production registry -eu-1 / github releases for go+dart)
- still unmerged (dirty or branch-only): global-ui, global-generics,
  dart-registry, rules + all stage 1-3 base repos

## INCIDENT: proto release pipelines failed on format.check (NOT ACCEPTABLE - learn)

- ROOT CAUSE: pnpm `install --lockfile-only` writes pnpm-lock.yaml WITH
  blank lines; the repos' `bazel run //tools/format:format.check` (yaml
  formatter) requires them stripped -> every npm proto repo release
  pipeline failed at format.check
- MY FAULT: I ran bazel build+test but NOT format.check before merging/
  tagging. MANDATORY RULE from now on: in every repo that has
  //tools/format, run `bazel run //tools/format:format.check` (or
  //tools/format:format to fix) BEFORE declaring a repo green - build+test
  alone is NOT enough
- fix: `bazel run //tools/format:format` (rewrites lock), commit, tag patch
- user manually patched 8 (v1.0.1 / email v1.12.1); agent patched the
  remaining 3 npm repos: user/content/billingstripe -> v1.0.1
- the 5 github-only internal/proto repos were format-clean (no lock
  changes); their v1.0.0 tag failures were NOT format -> likely UI cluster
  switch; retry build, no re-tag

## final proto versions (stage 5 must consume these)

| repo | version |
|---|---|
| global-proto | v2.25.0 |
| earth-user-service-proto | v1.0.3 |
| earth-user-service-internal-proto | v1.0.3 |
| earth-content-service-proto | v1.0.2 |
| earth-email-service-proto | v1.12.2 |
| earth-email-service-internal-proto | v1.0.0 |
| earth-emailmailgun-service-proto | v1.0.1 |
| earth-iam-service-proto | v1.0.2 |
| earth-language-service-proto | v1.0.2 |
| earth-authorization-service-proto | v1.0.2 |
| earth-authentication-service-proto | v1.0.2 |
| earth-billing-service-proto | v1.0.2 |
| earth-billing-service-internal-proto | v1.0.1 |
| earth-billingstripe-service-proto | v1.0.2 |
| earth-billingrevenuecat-service-proto | v1.0.1 |
| earth-resourcemanager-service-proto | v1.0.2 |
| earth-storage-service-proto | v1.0.2 |

Cross-dep audit result: user-internal-proto consumed user-proto v0.32.0 +
global-proto v2.23.0 -> bumped (user-proto v1.0.1, global v2.25.0). ALL
other proto repos also pinned global_proto v2.23.0 in MODULE.bazel
git_override (+go.mod where present) while npm was already 2.25.0 -> all
bumped to v2.25.0, gazelle+build+test+format.check green, new patch tags
(table above). email-internal has no proto deps (rules only). Remaining
nested pin: user-internal consumes user-proto v1.0.1 (not v1.0.2) - fine,
root git_override for global_proto wins over transitive; no churn loop.
MANDATORY stage-5 rule: check MODULE.bazel git_override + go.mod pins for
ALL proto deps, not just npm package.json.

## global-tfmodule-gsa + global-tfmodule-ksa (stage 4 stragglers, caught by user)

- both were MISSED in the stage-4 batch (README marked them DONE but only
  versions.tf/tflint had been updated on main by user; repo migration was
  missing). Migrated on chore/loeffel-io/0010: rules v0.17.18 -> v0.19.14,
  .bazelversion 6.4.0 -> 6.6.0 (WORKSPACE repos), .bazelrc GITHUB_TOKEN,
  pipeline -> agent-stack-k8s (6.6.0 image 014c9027, cache bucket
  mindful-global-tfmodule-<name>-bazel-production-eu-1, KSA
  global-tfmodule-<name>-production). bazel build+test PASS
- cross-repo added: global-base grants on both module GSAs
  (global-tfmodule-<name>-p), buildkite-base KSA files + BUILD entries
- applies PENDING: blocked on missing ADC
  (~/.config/gcloud/application_default_credentials.json GONE - likely
  consumed by the npmrc auth flow earlier; user must run
  `gcloud auth application-default login`), then: global-base tp apply ->
  buildkite-base tp apply (bazel clean + tp -- init first) + UI cluster
  switch for both pipelines
- NOTE: gsa module main.tf appends -eu-1 + location EU itself (that IS the
  v0.9.0 behavior); module repo tags v0.9.0 already exist - after this
  migration lands, next module release tag continues from v0.9.x
- PIPELINE GOTCHA (hit on tfmodule-gsa): old tfmodule pipelines had NO
  `*init` step; in agent-stack-k8s git-ssh comes from `. ${HOME}/init.sh`
  (old chart injected /secrets/ssh-key -> "no such identity" failure).
  EVERY migrated pipeline step needs `- *init` as first command

## proto releases ALL CONFIRMED (github release list checked)

- every proto repo released at its final version incl the 6 initially-red
  ones (billing x4, storage, user-internal) - user fixed/retried those;
  user-internal-proto published as v1.0.2 (supersedes table entry note)
- STAGE 4 FULLY DONE except: global-tfmodule-gsa/ksa applies (blocked on
  ADC restore) + their pipeline verification, and unmerged branches:
  global-ui, global-generics, dart-registry, rules
- READY FOR STAGE 5 (17 service repos). stage-5 must: git fetch + behind
  check first, use final proto versions table, run format.check, audit
  MODULE.bazel git_overrides + go.mod + package.json for proto pins
- earth-billingstripe-service-internal-proto +
  earth-emailmailgun-service-internal-proto: DEPRECATED, no longer used
  (user confirmed) - skip, no migration. STAGE 4 COMPLETE except
  tfmodule-gsa/ksa applies (ADC) + 4 unmerged branches

## npm registry verification (frontend deps) + checkpoint

- earth-production-504915 AR npm registries verified via console list: all
  11 earth proto packages published (recent update + size per registry);
  authentication was the scrolled-off first row - user confirmed complete
- frontend (hub/app/website) additionally consumes from global-504915:
  global-proto-production-eu-1 (2.25.0 published) + global-ui-production-eu-1
- CHECKPOINT: stage 4 fully done + verified. PAUSED - waiting for user
  go-ahead. Next steps on resume:
  1. tfmodule-gsa/ksa applies (needs `gcloud auth application-default login`
     first - ADC gone) + UI cluster switch for both pipelines
  2. merge unmerged stage-4 branches: rules, global-ui, global-generics,
     dart-registry (+ commit stage 1-3 base repos if desired)
  3. STAGE 5: 17 service repos - rules: git fetch + behind-check before
     branching, consume final proto versions table, MODULE.bazel/go.mod/
     package.json pin audit, format.check mandatory, npmrc auth flow
  4. revert tmp dev DNS fallback (35.244.133.111 / cdn 34.111.1.218)
  5. stripe duplicate cleanup in dashboards
- INCIDENT 2 (user-proto npm publish ENEEDAUTH us-central1): my
  `git checkout package.json` during the 2.24.0->2.25.0 bump dance REVERTED
  the migrated publishConfig.registry in earth-user-service-proto only ->
  v1.0.2 npm publish failed (github release succeeded). Fixed registry ->
  earth-production-504915/...-eu-1, tagged v1.0.3 (now the final user-proto
  version). All other 12 npm repos verified europe-west3. LESSON: after any
  `git checkout <file>`, re-verify ALL migrations in that file
- user-internal-proto bumped to user-proto v1.0.3 (MODULE.bazel bazel_dep +
  git_override + go.mod), verified, tagged v1.0.3 (final)
- global-ui RELEASED v1.0.0 (user merged+tagged) - global-ui DONE incl release
- user-internal-proto v1.0.3 RELEASE CONFIRMED. All proto releases final +
  released: see version table (user-proto v1.0.3, user-internal v1.0.3,
  global-ui v1.0.0, rest unchanged)

## stage 1+2 branches MERGED + DELETED

- base/global-base/earth-base/buildkite-base: 0010 merged into main
  (branches were ahead-only, clean, no conflicts), pushed, branch deleted
  locally + remotely. All 4 repos now on main.
- note: global-base + buildkite-base tfmodule grants/KSAs were committed by
  user before the merge (working trees were clean at merge time)
- stage 3 base repos (earth-*-base, billingstripe-config) still on their
  0010 branches - NOT yet merged

## stage 3 branches MERGED + DELETED

- all 15 stage-3 repos (14 earth-*-base + billingstripe-config): 0010 merged
  into main, pushed, branches deleted local+remote. All on main now.
- pre-merge fixes: billingstripe-config had my uncommitted tflint 0.39.0
  audit fix -> tested + committed first; authentication behind=1 was just
  the auth-to-authentication PR merge commit (shared content, clean merge)
- ALL 0010 branches everywhere are now merged+deleted (stages 1-4 except:
  rules/global-generics/dart-registry still on unmerged 0010 branches)

## stage 1-3 production release tags (triggering buildkite production pipelines)

- tagged + pushed on main: global-base v0.8.0, earth-base v1.7.0,
  buildkite-base + all 15 stage-3 repos v1.0.0 (first-ever tags there;
  production deploys are tag-gated `if: build.tag != null`)
- base repo has NO pipeline (bootstrap) -> no tag
- production has NEVER been deployed - expect first-run issues
  (bootstrap ordering, GKE+CSM two-pass applies, missing images)
- pipelines run FULL flow on tag builds (dev+staging deploy on branch main
  only, so tag builds run Global+Build+production deployment)
- ALL 18 production tag builds GREEN (user confirmed) - production is
  deployed for stages 1-3! (global-base v0.8.0, earth-base v1.7.0,
  buildkite-base + 15 stage-3 repos v1.0.0)
- REMAINING before/with stage 5: rules/global-generics/dart-registry
  unmerged 0010 branches, tfmodule-gsa/ksa applies (ADC) + releases,
  tmp dev DNS fallback revert, stripe duplicate cleanup, app-base
  production SHA hashes

## stage 4 branch cleanup DONE

- audit showed ALL stage-4 0010 work already in main (ahead=0 everywhere;
  user had merged rules/global-generics/dart-registry/tfmodule-gsa/ksa +
  applied the tfmodules). Cleanup: all repos on main, stale local 0010
  branches deleted, global-ui remote 0010 branch deleted. NO 0010 branches
  left in ANY repo (stages 1-4 all merged+cleaned)
- clarifications from user: dns revert LATER (still pending!), app-base
  production SHA hashes STAY as-is (done), stripe cleanup = archiving the
  orphaned duplicate products/webhooks in the stripe dashboards from the
  import dance (user unsure - LOW PRIO, purely cosmetic in stripe UI)
- post-merge tag state: rules v0.23.2, global-generics v0.43.0,
  tfmodule-gsa/ksa v0.9.0 (pre-migration tags; if a release with migrated
  pipeline is wanted, user tags new versions - gsa/ksa module CONSUMERS pin
  ?ref=v0.9.0 which still resolves fine), dart-registry untagged (branch
  deploys only)
- NEXT: stage 5 (17 service repos)
- stripe duplicate cleanup DONE by user (orphaned products/webhooks removed
  from the dashboards). Stripe migration fully closed.

## stage 5 started - earth-openfga-service DONE (the stage-5 recipe)

CRITICAL RULES FIX FIRST: rules main (MODULE line v0.22+) had LOST the
`-eu-1` in gcloud_lib.sh gcloud_gke_auth cluster name (v0.19.14 WORKSPACE
line had it; lost in the kubectl/gcloud upgrade commit). Fixed on main ->
rules v0.23.3. ALL stage-5 repos must pin rules >= v0.23.3 or kubectl auth
fails against earth-gke-<env>-eu-1.

earth-openfga-service recipe (template for other 16 service repos):
1. git fetch + pull main first, branch chore/loeffel-io/0010
2. vars.bzl: region europe-west3 (docker_registry derives from it)
3. deployments/{dev,staging,production}/vars.bzl: project ids -504915
4. MODULE.bazel: rules git_override + bazel_dep -> v0.23.3
5. image.bzl: AR repo path needs -eu-1 (`-openfga-service-<env>-eu-1/`)
6. cmd BUILD.bazel k8s substitutions:
   - dbHost sql instance name + "-eu-1" (instances renamed in base repos)
   - dbPrivateIp -> per-README mysql ip (openfga 172.17.0.2 all envs;
     others per README stage-3 lines, e.g. user 172.17.0.10)
   - PRODUCTION templates did not exist -> replicate staging block
     (env_staging -> env_production), add production to service_account
     dict, load production vars.bzl
6b. cmd yaml fixes (repos with sql sidecar):
   - egress.yaml: mysql SE must NOT reuse sqladmin.googleapis.com host ->
     unique host mysql.google.internal + resolution STATIC + endpoints
     (copy from openfga)
   - service.yaml cloud-sql-proxy image ->
     @sha256:a6eab4b8c0e9da72c04a9456100ddafdeef076561e2569edcaede3e6d248d3eb
   - service.yaml annotation MUST bypass metadata server interception:
     traffic.sidecar.istio.io/excludeOutboundIPRanges include
     169.254.169.254/32 (append to existing ranges, e.g. authorization
     has "%{redisClusterSubnet},169.254.169.254/32"). Root cause: TD
     mesh intercepting metadata traffic caused flaky 502/503 +
     connection-refused token fetch errors everywhere (old in-cluster
     ASM istiod tolerated it). ALL stage-5 services need this (also
     no-sql repos - anything doing GCP auth). done: openfga +
     authorization + authentication (all uncommitted)
   - pipeline kubectl order: egress -> auth -> (ingressgateway) ->
     service LAST
   - grep '382708' (vars.bzl concatenation mangle, hit authentication)
7. deployments/production/BUILD.bazel: replicate from staging (was stub
   with only files filegroup)
8. pipeline: agent-stack-k8s, 8.6.0 digest 6a226aeb, buckets -eu-1
   (service bazel buckets exist via base-repo gsa module), dev container
   env MINDFUL_USER=master, serviceAccountName earth-<svc>-service-<env>
9. cross-repo NEW for stage 5 (SERVICE ksa, distinct from base ksa!):
   - owning base repo: serviceAccountAdmin grant on the SERVICE gsa
     (gsa_earth_<svc>_service_<env>) for buildkite-base-p, ALL 3 ENVS
     (earth-openfga-base earth_openfga_service.tf all envs)
   - buildkite-base: earth_<svc>_service_{dev,staging,production}.tf KSA
     files (KSA name earth-<svc>-service-<env> = pipeline SA, gsa email
     earth-<svc>-s-<e>@earth-<env>-504915) + BUILD entries
10. bazel build+test+format.check (buildifier reformats BUILD after edits -
    run //tools/format:format once) + validate base repo (td/ts/tp) +
    buildkite-base tp
11. apply order: base repo (grants, all envs) -> buildkite-base ->
    UI cluster switch -> merge (dev+staging deploy) -> tag v1.0.0 (prod)

openfga-service state: all green (build/test/format; openfga-base 3 envs +
buildkite-base validate ok), UNCOMMITTED in all 3 repos. loggerDevelopment
kept True in production (staging parity - user may want False later).

## stage 5: earth-authentication-service DONE

- SPECIAL: 0010 branch based on origin/feat/loeffel-io/auth-to-authentication-migration
  (9 ahead of main, full auth->authentication rename incl module path,
  cmd dirs, kubectl/oci bzl, pipeline SAs). Merge flow: that branch lands
  WITH 0010 (like authentication-base earlier)
- has AGENTS.md (forbids editing build/buildkite + deployments; user's
  migration order supersedes - noted deviation). AGENTS commands used:
  `bazel run @rules_go//go -- mod tidy && bazel run //:gazelle && bazel mod
  tidy`, format target is `//:format` (NOT //tools/format:format)
- recipe additions vs openfga:
  - proto dep bumps to FINAL versions in MODULE.bazel git_overrides + go.mod
    (authentication 1.0.2, authorization 1.0.2, resourcemanager 1.0.2,
    email 1.12.2, user 1.0.3, user-internal 1.0.3, global_proto 2.25.0)
  - NEW firebase tenant ids from README vite_env block:
    dev mindful-3kqub (was mindful-sijsm), staging mindful-s4qzq (was
    mindful-i0u7b), production mindful-ru4mc
    (%{accountSeederMindfulTenantId})
  - production ingressgateway domain = authentication.mindful.com (apex)
  - no sql -> no dbHost/dbPrivateIp anywhere
  - accountSeederSeedFirebaseUsers kept True in production (staging parity
    - user may want False; flag on review)
- cross-repo: grants in earth-authentication-base all 3 envs + buildkite-base
  earth_authentication_service_{dev,staging,production}.tf KSAs
- validate: dev/staging via tp wrapper green; production wrapper hit local
  gcloud auth issue (account missing in prod CLOUDSDK profile - user env,
  not config) -> verified with plain terraform validate: Success
- all UNCOMMITTED (service repo + authentication-base + buildkite-base)
- CORRECTION authentication-service: 0010 should have been based on
  chore/loeffel-io/0009 (= rename branch + "chore: 0009" + cookie
  cloudflare test), NOT the rename branch directly. Fixed by merging
  origin/chore/loeffel-io/0009 into 0010; conflicts were only proto pins
  (kept OUR final versions); found+fixed silent miss: MODULE.bazel
  authorization pin was v0.10.0 on the branch (my v0.9.0-replace no-op'd)
  -> v1.0.2. Build+test+format green, pushed. LESSON: before branching a
  service repo, check for the LATEST chore/loeffel-io/00XX branch and base
  on that (repos carry in-flight sequential migration branches)

## STAGING CLUSTER REBUILD RUNBOOK (ON HOLD - cheap path first)

PLAN CHANGE: try the CHEAP PATH before any rebuild. earth-base now
ships BOTH MeshConfig configmaps (istio-asm-managed AND
istio-asm-managed-rapid, identical content) + release_channel REGULAR
(uncommitted, validate+build green all envs) -> revision-agnostic:
whichever revision Google wires, our config is read.
CHEAP PATH steps (user):
1. `ts -- import kubernetes_config_map_v1.kubernetes_config_map_v1_istio_asm_managed_rapid "istio-system/istio-asm-managed-rapid"`
   (Google created it 9d ago -> import else 409; QUOTE the id - shell
   line wrap truncated it once)
2. `ts -- apply`
3. `kubectl -n earth-openfga-service delete pod -l app=earth-openfga-service`
4. 5min -> `istioctl proxy-config listeners deploy/earth-openfga-service -n earth-openfga-service | wc -l`
CHEAP PATH ROUND 3 = THE DOC-SANCTIONED CONSOLIDATION (final plan):
Round 2 (creating asm-managed-rapid CPR) provisioned successfully BUT
triggered `UNSUPPORTED_MULTIPLE_CONTROL_PLANES` in fleet state - two
CPRs are explicitly unsupported. The modernization doc "Fix multiple
control planes" prescribes the OPPOSITE: consolidate to ONE channel
matching the GKE cluster channel (REGULAR -> keep asm-managed), and
EXPLICITLY sanctions kubectl-deleting the extra channel's Google-
managed artifacts; the reconciler recreates the webhooks correctly
once a single channel remains. THAT is the mechanism that fixes the
stale rapid injection wiring.
- terraform reverted (uncommitted, validate+build green): rapid CPR
  resource + rapid configmap resource REMOVED again from earth-base
  all envs. Both are in staging tf STATE (imported cm + created CPR)
  -> next ts -- apply DESTROYS them from the cluster (desired!)
- USER STEPS (staging):
  1. ts -- apply  (destroys asm-managed-rapid CPR + istio-asm-managed-
     rapid configmap; keeps asm-managed CPR-less setup... NOTE: no
     asm-managed CPR in tf - it was Google-created; it stays)
  2. doc consolidation deletes (sanctioned):
     kubectl delete mutatingwebhookconfiguration istiod-asm-managed
     kubectl delete mutatingwebhookconfiguration istio-revision-tag-default
     (reconciler recreates both pointing at the single remaining
     channel; there is no istiod-asm-managed-rapid webhook to delete;
     env-asm-managed-rapid configmap left for the reconciler)
  3. re-trigger reconcile: gcloud container fleet mesh update
     --management automatic --memberships earth-gke-staging-eu-1-membership
     --project earth-staging-504915 --location global
  4. wait 15-20min; verify webhook recreated + URL contains
     /controlPlanes/asm-managed/inject (NOT -rapid)
  5. kubectl -n earth-openfga-service delete pod -l app=earth-openfga-service
  6. verify pod annotation istio.io/rev=asm-managed + listeners populate
- if webhooks come back rapid-wired AGAIN despite single-channel state:
  Google bug confirmed beyond doubt -> issuetracker.google.com +
  fallback options: cluster rebuild (runbook below) or re-add the rapid
  CPR pair and accept UNSUPPORTED_MULTIPLE_CONTROL_PLANES warning
  (it provisioned fine; pods held at pilot-agent wait though - CP
  existed but config still didn't flow, possibly needed more time)


Listeners populate = HEALED, no rebuild, same fix applies to dev/prod
(import may or may not be needed there - check if the rapid configmap
exists). Listeners still empty = rapid control plane broken server-side
-> THEN rebuild below (gate at step 3 tells whether fresh clusters get
regular or rapid wiring) or issuetracker.

USER CONFIRMED: all 3 clusters (dev/staging/production) are on the
REGULAR channel RIGHT NOW. So the explicit `release_channel REGULAR`
in terraform matches live state = pure no-op codification on existing
clusters (no plan churn expected beyond the block itself), and the
rapid injection wiring is definitively STALE leftover from the 1.35
rapid bootstrap - not an active channel setting. Also means dev +
production very likely carry the SAME stale rapid webhooks (created
from same terraform at similar times) -> check their
`kubectl get mutatingwebhookconfiguration istiod-asm-managed -o yaml | grep url:`
before deciding rebuild vs. in-place fix per cluster.

DECISION: staging cluster earth-gke-staging-eu-1 gets DESTROYED +
RECREATED. Rationale: Google's mesh provisioning is in an unrecoverable
half-state (rapid injection webhooks on a REGULAR cluster, phantom
asm-managed shells); patching means running forever on workarounds.
Everything is rebuildable from code; SQL/buckets/DNS/certs live outside
the cluster and survive. Rehearses the same procedure production will
likely need (same terraform created its cluster - CHECK its webhook
urls before go-live: `kubectl get mutatingwebhookconfiguration
istiod-asm-managed -o yaml | grep url:` - rapid = same disease).

TERRAFORM PREP DONE (earth-base, uncommitted, validate+fmt+build green
all envs): 1) cluster resource now has explicit `release_channel {
channel = "REGULAR" }` (prevents the rapid-bootstrap drift that caused
all this; 1.35 is in REGULAR now per cluster describe), 2) removed the
istio-asm-managed-rapid configmap duplicate again (fresh cluster will
be regular-wired; single istio-asm-managed configmap suffices),
3) EnvoyFilter TD-compliant rewrite + stackdriver removal retained.

RUNBOOK (user runs, staging):
1. earth-base: `ts -- destroy` the cluster + dependents. Simplest
   reliable path: `ts -- destroy -target=google_container_cluster.cluster`
   (terraform cascades in-cluster resources' reality away; state of
   k8s resources in OTHER repos becomes stale-but-refreshable).
   Watch out: gateway/certmap/global-address are cluster-external and
   should NOT be destroyed - target only the cluster.
2. `ts -- apply` pass 1: `-target=google_container_cluster.cluster
   -target=google_gke_hub_membership.membership
   -target=google_gke_hub_feature_membership.servicemesh_member`
   then WAIT for CSM CRDs (minutes after feature ACTIVE; check
   `kubectl get crd | grep istio`).
3. `ts -- apply` pass 2 (full): creates istio-system configmap,
   PeerAuth/RequestAuth/AuthorizationPolicy/EnvoyFilter, earth-base ns,
   Gateway. May need kubeconfig refresh: `gcloud container clusters
   get-credentials earth-gke-staging-eu-1 --region europe-west3`.
4. VERIFY MESH WIRING BEFORE ANYTHING ELSE:
   `kubectl get mutatingwebhookconfiguration istiod-asm-managed -o yaml | grep url:`
   must contain /controlPlanes/asm-managed/ (NOT -rapid). If rapid
   again despite REGULAR channel -> issuetracker.google.com, stop.
5. all 14 earth-*-base repos: `ts -- apply` each (recreates namespaces,
   KSAs, TLS secrets from existing state; refresh sees them gone, no
   imports needed). bazel clean + ts -- init if stale-file gotcha.
6. service deploys: `mmfd staging openfga authorization authentication`
   (order in mmfd is already egress-before-service).
7. verify: listeners populate (`istioctl proxy-config listeners ...`),
   sql connects, cookie login works, EnvoyFilter status Accepted,
   fleet describe clean.
8. AFTER staging verified: consider same rebuild for dev + production
   clusters (check their webhook urls first - if they say asm-managed
   already, only the earth-base apply (EnvoyFilter/stackdriver/
   release_channel) + transcoder EnvoyFilter deletion is needed).
9. cleanup after heal: remove tmp mesh bypass annotations
   (rg 'tmp mesh bypass' in service repos) once mesh delivers config.



## BREAKTHROUGH: webhooks recreated for rapid - final alignment (2026-08-20 ~14:30)

- fresh staging cluster sequence that WORKED: ts apply created our
  asm-managed-rapid CPR (+ imported the Google-precreated
  istio-asm-managed-rapid configmap, overwritten with OUR meshconfig);
  Google's own asm-managed CPR disappeared during consolidation (its
  deprovision also wiped the webhooks); then user ran on the rapid CPR:
  `kubectl label controlplanerevision asm-managed-rapid -n istio-system mesh.cloud.google.com/managed-cni-enabled=true --overwrite`
  `kubectl annotate controlplanerevision asm-managed-rapid -n istio-system mesh.cloud.google.com/force-reprovision=true --overwrite`
  -> ~10min later webhooks appeared: istiod-asm-managed-rapid +
  istio-revision-tag-default. LESSON: a bare terraform-created CPR
  (no labels) does NOT get webhooks; the managed-cni-enabled label +
  force-reprovision were required
- LABEL ALIGNMENT (terraform, uncommitted): the new webhook matches
  rev=asm-managed-rapid; our namespaces said asm-managed -> would get
  NO sidecar. Flipped ALL istio.io/rev=asm-managed labels to
  `"istio-injection" = "enabled"` (doc best practice, channel-agnostic,
  matched by istio-revision-tag-default): 51 files across 14
  earth-*-base repos + earth-base ns (all 3 envs). All validate green
- earth-base CPR resource now carries labels
  mesh.cloud.google.com/managed-cni-enabled=true + computed_fields
  metadata.annotations (so the force-reprovision annotation doesn't
  drift)
- FINAL TARGET STATE (staging, to replicate on dev+production): single
  CPR asm-managed-rapid (rapid mesh channel is FORCED by Google's
  injection wiring even on REGULAR clusters - doc says channel choice
  does not matter, GKE cluster channel governs the mesh version);
  meshconfig istio-asm-managed-rapid (ours via terraform, import may be
  needed); namespaces istio-injection=enabled; webhooks
  istiod-asm-managed-rapid + tag-default
- NEXT: verify webhook url (expect asm-managed-rapid/inject), full ts
  apply if pending, 14 base repos ts apply (label change = in-place ns
  update), mmfd staging openfga authorization authentication, verify
  pod has 3 containers + revision annotation asm-managed-rapid +
  listeners populate + sql connects
- dev/production replication: same terraform now; the CPR label+
  annotation kubectl commands are needed per cluster (or bake label in
  tf - done - and only force-reprovision manually)

## earth-base staging apply attempt 1: two errors + fixes (2026-08-20 ~15:00)

- ERROR 1 (CPR): "Provider produced inconsistent result after apply" -
  Google's controller re-adds label istio.io/owned-by=mesh.googleapis.com
  right after our patch. FIX (uncommitted, all 3 envs of earth-base):
  computed_fields now ["metadata.annotations", "metadata.labels"].
  The managed-cni-enabled label likely DID land on the cluster (error is
  post-apply consistency check); re-apply converges state
- ERROR 2 (ns patch 403): earth-base-s SA cannot patch namespaces
  (needs container.namespaces.update). ROOT CAUSE: local ts applies
  impersonate the env SA which only has roles/container.clusterAdmin
  (cluster ops, NOT k8s objects); CI works because buildkite-base-p has
  roles/container.admin. Same gap caused the earlier
  thirdPartyObjects.delete 403. FIX (uncommitted, base repo
  deployments/production/earth_base_{dev,staging,production}.tf): added
  roles/container.admin to the earth-base SA roles, matching buildkite
- ORDER: 1) base repo ts -- apply (grants the role; needs an identity
  with IAM admin on the earth projects), 2) earth-base staging
  ts -- apply again (both resources converge in-place). Interim
  workaround if base apply blocked: cloudshell admin
  `kubectl label ns earth-base istio-injection=enabled istio.io/rev- --overwrite`
  then earth-base apply only refreshes

## STAGING MESH VERIFIED HEALED (2026-08-20 ~15:30)

- base + earth-base + earth-openfga-base applied clean (container.admin
  + computed_fields labels fixes worked)
- mmfd staging openfga: pod 3/3, revision annotation asm-managed-rapid,
  6 early restarts = startup race before envoy ready (harmless;
  holdApplicationUntilProxyStarts now active so future pods won't race)
- PROOF listeners populated incl our ServiceEntries: sqladmin SNI,
  www.googleapis.com SNI, mysql.google.internal:3307 - the exact egress
  that was blackholed before
- PROOF configmap istio-asm-managed-rapid = OUR meshconfig
  (REGISTRY_ONLY, extauthz authorization.local:4000, holdApplication)
  -> rapid CP finally reads our config
- `istioctl proxy-status` -> "unable to find any Istiod instances" is
  EXPECTED with managed ASM (no in-cluster istiod); not an error
- canary: re-check listeners after ~30min (old blackhole appeared at
  first config push) before rolling authorization/authentication
- REMAINING: earth-authorization-base + earth-authentication-base ts
  apply (ns label flip) BEFORE mmfd of those services; then remaining
  ~11 base repos; then remove tmp mesh bypass annotations; then
  dev+production replication (base roles + earth-base computed_fields
  already cover all envs; per-cluster force-reprovision annotation may
  be needed)


## TD CONFIG STARVATION: mesh broke again ~15:15 2026-08-20, root = Google TD (2026-08-21)

- TIMELINE: 14:50 openfga pod got FULL config (listeners incl sqladmin
  SNI, sql worked). ~15:15 authorization+authentication deploys landed
  (CUSTOM extauthz APs, RA, ingressgateways). Since then EVERY new
  proxy (sidecars AND ingressgateway) gets ZERO LDS/CDS from TD.
  istio-proxy log signature: xdsproxy connects to
  meshconfig.googleapis.com OK, SDS certs pushed OK, then NOTHING ->
  probe errors "Failed to create grpc connection to probe app" for 60s
  -> postStart hook (pilot-agent wait, from holdApplicationUntil
  ProxyStarts) times out -> kubelet kills istio-proxy -> crashloop.
  `istioctl proxy-config listeners <pod>` = 3 lines (empty). cloud-sql
  "connection refused" to sqladmin = downstream symptom (iptables
  redirects 443 into config-less envoy)
- ELIMINATION LADDER (all deleted live, pod recreated between each, NO
  effect): CUSTOM APs *-authorization, EnvoyFilter jwt-cookie-to-
  authorization-header, RA mesh-wide (istio-system), RA
  ...-ingressgateway-google-request-authentication, AP mesh-wide-
  allow-nothing, meshconfig stripped to minimal ALLOW_ANY (no
  extensionProviders), finally ALL custom istio config purged from
  earth-base staging main.tf (removed: authorization ServiceEntry,
  mesh-wide RA, allow-nothing AP, jwt-cookie EnvoyFilter; kept: CPR,
  minimal cm, PeerAuth STRICT, Gateway) + applied -> STILL starved.
  OUR CONFIG IS EXONERATED
- final clean evidence pod: excludeOutboundPorts "443,3307" on ->
  0 restarts, app+sql healthy (bypass), istio-proxy ready=false,
  3 listeners. Bypass annotation = legit stopgap now, NOT related to
  1.20 DNS limitation (sqladmin resolves via kube-dns; refused
  happens inside envoy)
- fleet describe LIES: REVISION_READY + dataPlaneManagement ACTIVE
  while all proxies starve. Earlier CONFIG_VALIDATION_WARNING
  [RequestAuthentication] was only outputClaimToHeaders unsupported-
  field warning (Accepted), not the cause. NOTE: TD never sets
  x-mindful-* claim headers (outputClaimToHeaders unsupported!) -
  downstream consumers broken even when mesh works
- TD unsupported-features doc (user found): outputClaimToHeaders,
  EnvoyFilter (restrictions), DNS-proxy hostname resolution needs
  sidecar >=1.21.5 (running 1.20.8 -> authorization.local /
  mysql.google.internal istio-DNS never resolves; mysql OK via
  addresses+STATIC IP). extauthz/CUSTOM+lua design is a bad fit for
  TD overall
- NEXT: file issuetracker.google.com case (managed ASM / TD): zero
  xDS since 15:15 despite clean config, one pod provably worked at
  14:50, fleet state green while starving. Ask whether cluster can
  run managed-istiod implementation instead of TRAFFIC_DIRECTOR
  (supports EnvoyFilter/extauthz/outputClaimToHeaders)
- staging main.tf now minimal (uncommitted); dev/production main.tf
  still have full istio config - do NOT replicate until TD case
  resolved


## TRUE ROOT CAUSE FOUND: invalid Service port name "sql" (2026-08-21 ~07:30)

- TD builds LDS from the workload's k8s Service; a port named `sql`
  (invalid istio protocol prefix) makes TD SILENTLY refuse to build
  LDS/RDS for the ENTIRE proxy (CDS still SYNCED, LDS "Not Found").
  istiod tolerates unknown names (plain TCP); TD does not. THIS was
  the whole "no egress/blackhole" saga - not the CPR/webhook wiring
  (that was a real but separate problem, fixed earlier), not SEs, not
  EnvoyFilter/extauthz/RA/APs (elimination ladder proved all innocent)
- PROOF: `kubectl patch svc earth-openfga-service -n
  earth-openfga-service --type=json -p='[{"op":"replace","path":
  "/spec/ports/2/name","value":"tcp-sql"}]'` + pod recreate ->
  LDS/RDS SYNCED instantly. Working authentication ns never had a
  sql/dlv port; broken openfga+authorization both did
- key debug tool discovered: `gcloud beta container fleet mesh debug
  proxy-status --membership=earth-gke-staging-eu-1-membership
  --project earth-staging-504915` shows per-proxy CDS/LDS/RDS sync
  (works with managed TD where istioctl proxy-status fails)
- FIXED IN SOURCE (uncommitted): renamed `sql`->`tcp-sql`,
  `dlv`->`tcp-dlv` in service.yaml of 13 repos: earth-{app,
  authorization,billing,billingstripe,content,email,hub,iam,openfga,
  resourcemanager,storage,user,website}-service
- CLUSTER DRIFT from debugging (staging): live-patched openfga svc
  port name (redeploy makes it consistent); DELETED live + from
  earth-base staging main.tf: authorization SE (authorization.local),
  mesh-wide RA, mesh-wide-allow-nothing AP, jwt-cookie EnvoyFilter;
  meshconfig cm now minimal ALLOW_ANY. openfga ns SEs deleted live
  but come back with next mmfd (egress.yaml unchanged). authorization
  CUSTOM APs + authentication ingressgateway RA deleted live, come
  back with next mmfd
- RESTORE DECISIONS PENDING (earth-base staging main.tf): re-add
  REGISTRY_ONLY? (was innocent) extensionProviders/extauthz + CUSTOM
  APs + EnvoyFilter lua + outputClaimToHeaders are TD-UNSUPPORTED ->
  auth architecture needs TD-compatible redesign OR move mesh to
  managed-istiod implementation. mesh-wide RA jwksUri also broken
  (identitytoolkit publicKeys = PEM not JWKS)
- NEXT: commit+push the 13 service repos + earth-base, mmfd staging
  openfga authorization authentication, verify LDS SYNCED + sql
  connects + remove excludeOutboundPorts bypasses, then replicate
  port-name fix insight to dev/production (same 13 repos deploy
  everywhere; dev/prod earth-base main.tf still has full istio config
  - decide restore set first)


## DAY 2 AFTERNOON: authorization workload stuck at TD (2026-08-21 ~09-10)

- full config restored in earth-base staging main.tf (REGISTRY_ONLY +
  extensionProviders + authorization SE + mesh-wide RA original +
  allow-nothing AP + EnvoyFilter). VERDICTS with proper 5-10min waits
  (TD convergence is SLOW - many earlier verdicts were premature!):
  openfga SYNCED under full config with zero SEs; authentication
  SYNCED with googleapis(DNS)+metadata(STATIC) SEs; CUSTOM AP existing
  did NOT break openfga (provider defined)
- authorization workload PERMANENTLY LDS Not Found regardless of:
  SEs deleted (mysql, redis, ALL), CUSTOM AP deleted, tcp-dlv port
  removed, istio-system authorization SE deleted, scale 0->1 cycle.
  Plus 3x `Error calling trafficdirector.googleapis.com: rpc error:
  code = Internal` (08:36:54, 09:10:04, 09:22:55 UTC) always around
  this workload -> POISONED TD SERVER-SIDE STATE for identity
  earth-authorization-service suspected
- CRITICAL DOC FIND: TD does NOT support `location: MESH_INTERNAL` in
  ServiceEntry - and MESH_INTERNAL is the DEFAULT when omitted. Our
  authorization SE (istio-system, extauthz target) omitted location!
  FIXED in main.tf: added location=MESH_EXTERNAL. Theory: that SE
  poisoned TD config-gen for the workload SERVING its endpoint port
  (4000) = exactly authorization
- pending test: clone deployment with new name/label (jq rename) -
  if clone syncs, identity is poisoned -> UNBLOCK = rename workload
  (e.g. -v2) in authorization base/service repos
- strategic option discussed: NEW CLUSTER on rapid channel -> istio
  1.21+: fromCookies (kills EnvoyFilter need), DNS proxy (fake
  hostnames work). Medium-term, not tonight
- cluster drift note: openfga deploy annotation still has
  holdApplicationUntilProxyStarts:false bypass + tcp-dlv port patch
  live-only; authorization svc dlv port removed live only


## RESOLUTION: staging rebuilt on RAPID channel - EVERYTHING WORKS (2026-08-21 ~13:00)

- user destroyed staging cluster, recreated with release_channel RAPID
  (min_master_version 1.35 + RAPID now in staging main.tf). Google
  auto-provisioned CLEAN: single asm-managed-rapid CPR, both webhooks
  correct from birth, sidecar 1.21.6-asm.38 (>= 1.21 unlocks
  fromCookies + DNS proxy). NO manual force-reprovision needed
- dev exposed the toxins via fleet describe: CONFIG_VALIDATION_ERROR
  [EnvoyFilter] (severity ERROR - old committed INSERT_BEFORE/
  jwt_authn shape FAILS application on TD) + UNSUPPORTED_MULTIPLE_
  CONTROL_PLANES. staging (old cluster) authorization stayed broken
  even in clean-config state = written off as poisoned TD state +
   EnvoyFilter error
- CHANGES (all uncommitted): earth-base staging main.tf: EnvoyFilter
  jwt-cookie COMMENTED OUT, RA mesh-wide now uses fromCookies=["jwt"]
  (1.21 native - replaces lua filter), old istio-asm-managed cm
  REMOVED (only rapid cm remains), all cms REGISTRY_ONLY (also dev+
  prod), authorization SE has location=MESH_EXTERNAL (TD doesn't
  support MESH_INTERNAL default!). openfga service.yaml: bypass
  holdApplicationUntilProxyStarts:false removed; egress googleapis
  back to HTTPS/DNS (was TLS/NONE experiment). authorization
  egress.yaml: redis SE (NONE+CIDR, most TD-hostile shape) DELETED -
  redis rides the iptables exclusion %{redisClusterSubnet} anyway.
  authentication service.yaml: stale bypass comment removed
- VERIFIED HEALED on new cluster (native, NO bypasses): openfga 3/3,
  sql connected, migrations ran, listeners incl sqladmin SNI +
  mysql:3307; authorization SYNCED with extauthz container + CUSTOM
  AP + provider = THE ARCHITECTURE WAS NEVER THE PROBLEM; fleet
  describe fully clean except known-harmless outputClaimToHeaders
  warning (TD never sets x-mindful-* headers - check downstream
  consumers someday)
- REMAINING: authentication mmfd + verify; cookie login e2e (now via
  fromCookies not lua!); commit 13 service repos (service.yaml port
  fixes; leave debug strings in main.go out) + earth-base + base +
  14 earth-*-base repos; dev+production: replicate rapid-cluster
  rebuild OR fix in place (delete extra CPR + EnvoyFilter, keep
  1.20-compatible config until rebuilt); remove remaining
  excludeOutboundPorts bypasses in other service repos when deployed
- LESSONS: TD verdicts need 5-10min waits (many false negatives from
  impatience); `gcloud beta container fleet mesh debug proxy-status
  --membership=X --project=Y` is THE tool; fleet describe names
  invalid config types; TD is strict: no invalid port names (sql/dlv
  -> tcp-*), no MESH_INTERNAL SEs, no NONE+CIDR SEs, EnvoyFilter
  shapes validated hard


## CONSOLIDATION EXECUTION LOG (live, 2026-08-20 ~12:30-13:00 UTC)


- ts -- apply: rapid configmap destroyed OK; rapid CPR delete FAILED
  with 403 (earth-base-s SA lacks container.thirdPartyObjects.delete)
  -> user deleted CPR via cloudshell admin account; delete HANGS in
  Terminating (finalizer mesh.cloud.google.com/deprovision - Google
  actively deprovisioning the rapid control plane, takes 10-20min).
  If stuck >20min: kubectl patch controlplanerevision asm-managed-rapid
  -n istio-system --type merge -p '{"metadata":{"finalizers":[]}}'
- ts -- state rm kubernetes_manifest.kubernetes_manifest_control_plane_revision_asm_managed_rapid
  (user should run if not yet done - CPR no longer in terraform code)
- SIDE EFFECT of the rapid deprovision: BOTH istio mutatingwebhook-
  configurations (istiod-asm-managed AND istio-revision-tag-default)
  are GONE - the whole injection wiring belonged to the rapid CP.
  Cluster currently has NO istio injection webhooks: DO NOT deploy or
  restart workloads until they are recreated (pods would get NO sidecar)
- IMPORTANT ownership facts: asm-managed CPR (regular) was created by
  GOOGLE at cluster birth Aug 11 (labels owned-by=mesh.googleapis.com),
  NOT by our terraform - it stays and is not in tf state. The rapid CPR
  was OURS (3h-old experiment). The ORIGINAL bug was Google provisioning
  installers wired to asm-managed-rapid while only the asm-managed CP
  existed - from day one; MISSING_CONTROL_PLANE_CONFIG was hinting this
- user ran `gcloud container fleet mesh update --management automatic
  ...` -> reconciler must now REBUILD the webhooks from current state
  (single regular CPR, REGULAR cluster channel, no rapid artifacts)
- FINISH LINE check when istiod-asm-managed webhook reappears:
  `kubectl get mutatingwebhookconfiguration istiod-asm-managed -o yaml | grep url:`
  -> /controlPlanes/asm-managed/inject = FIXED -> pod delete -> verify
  injection annotation asm-managed -> listeners populate -> sql works
- if the rebuilt webhooks point at rapid AGAIN: upstream fleet-side
  record forces rapid -> ironclad issuetracker.google.com case; cluster
  rebuild would inherit the same bug, so don't bother rebuilding



## ROOT CAUSE FINAL: revision mismatch - Google provisioned RAPID, we configured REGULAR

- the days-long "no egress" saga root cause chain (staging, likely dev+
  production too): cluster terraform pins min_master_version 1.35
  WITHOUT release_channel -> GKE bootstrapped on RAPID (1.35 only there
  at creation) -> Google mesh reconciler provisioned control plane
  `asm-managed-rapid` (env-asm-managed-rapid + istio-asm-managed-rapid
  configmaps, injection webhooks). Cluster channel later moved to
  REGULAR + asm-managed CPR appeared, but Google's injection wiring
  NEVER retargeted: BOTH mutatingwebhookconfigurations (istiod-asm-
  managed AND istio-revision-tag-default) call
  .../controlPlanes/asm-managed-rapid/inject - verified via `kubectl
  get mutatingwebhookconfiguration ... | grep url:`. So ALL pods are
  injected as revision asm-managed-rapid regardless of namespace label
- consequence: sidecars announce asm-managed-rapid to meshconfig xDS;
  our MeshConfig lives in configmap `istio-asm-managed` which the
  rapid control plane NEVER READ. Zero LDS delivered -> the mesh-wide
  blackhole. All earlier fixes (EnvoyFilter shapes, transcoder
  removal) were real TD-validation problems but not sufficient
- istioctl tag set default --revision asm-managed did flip the tag
  metadata but the tag webhook URL still points at rapid injector ->
  no effect (Google-managed wiring)
- TERRAFORM FIX (earth-base, uncommitted, all 3 envs, validate+build
  green): duplicated the MeshConfig configmap as
  `kubernetes_config_map_v1_istio_asm_managed_rapid` (name
  istio-asm-managed-rapid, identical mesh content) - now BOTH revision
  names carry our config, whichever revision Google runs reads it.
  Namespace labels left as asm-managed (51 files; label does not
  influence injector routing here)
- APPLY GOTCHA: istio-asm-managed-rapid ALREADY EXISTS in staging
  (Google-created 9d ago) -> first apply 409s; import first:
  `ts -- import kubernetes_config_map_v1.kubernetes_config_map_v1_istio_asm_managed_rapid istio-system/istio-asm-managed-rapid`
  then ts -- apply (overwrites Google's content with ours: REGISTRY_
  ONLY + ext-authz + holdApplicationUntilProxyStarts). Same for dev/
  production if the rapid configmap exists there
- after apply: delete openfga pod, expect listeners to FINALLY
  populate (sidecar revision asm-managed-rapid + our meshconfig in
  istio-asm-managed-rapid + validation-clean = all pieces aligned)
- LONG-TERM followups: add explicit `release_channel { channel =
  "REGULAR" }` to cluster resource (prevents channel drift; verify
  1.35/REGULAR compatibility first), keep dual configmaps until Google
  fixes the webhook wiring to regular, then optionally drop the rapid
  one. File issuetracker.google.com issue about the stale rapid
  injection wiring on REGULAR-channel cluster



## CURRENT STATE CHECKPOINT (superseded by ROOT CAUSE FINAL above - kept for history)

WHERE WE ARE (staging, 2026-08-20 ~08:15 UTC):
- CONFIG_VALIDATION_ERROR is GONE from `gcloud container fleet mesh
  describe` (only warnings left: RequestAuthentication + stale
  MISSING_CONTROL_PLANE_CONFIG)
- BUT sidecars still get NO listener config (istioctl proxy-config
  listeners = 3 lines); istio-proxy log shows clean xDS connect + SDS
  certs, then SILENCE - no LDS/CDS, no NACKs -> TD server-side not
  generating config after the long poisoned period
- user annotated `controlplanerevision asm-managed -n istio-system
  mesh.cloud.google.com/force-reprovision=true` (documented lever) ->
  WAITING 15-20min for control plane reprovision
- NEXT: recheck fleet describe (REVISION_READY cycles) + listener count.
  Dozens of listeners = healed -> rollout restart openfga/authorization/
  authentication, verify SQL connect, test cookie login via gateway.
  Still 3 = Google support case "TD not pushing xDS after
  CONFIG_VALIDATION_ERROR recovery" (evidence: API enabled, CPR
  reconciled, EnvoyFilter Accepted, clean xDS stream, no NACKs)
- UPDATE post-reprovision: reprovision COMPLETED (REVISION_READY/
  ACTIVE, VPCSC_GA_SUPPORTED INFO appeared = fresh control plane) but
  STILL no dynamic listeners. Raw `istioctl proxy-config listeners`
  shows ONLY static admin listeners 15021+15090 - NO virtualOutbound
  15001 / virtualInbound 15006 / service routes -> zero LDS ever
  delivered. Egress yamls definitively NOT the cause (no outbound
  listener exists for SEs to attach to; identical files worked
  pre-incident; gateways don't use them and fail too)
- USER-SIDE REMEDIATION EXHAUSTED -> 1) Google support case P2 (CSM
  TD control plane READY/ACTIVE but no LDS/CDS despite clean xDS,
  post-CONFIG_VALIDATION_ERROR recovery, force-reprovision didn't
  help, MISSING_CONTROL_PLANE_CONFIG persists despite reconciled CPR),
  2) parallel long shot: re-run `gcloud container fleet mesh update
  --management automatic --memberships earth-gke-staging-eu-1-membership
  --project earth-staging-504915 --location global` (idempotent,
  forces full reconcile path), wait 15-20min, recheck
- manual->automatic management toggle DONE by user: no change,
  MISSING_CONTROL_PLANE_CONFIG persists. terraform verified IDENTICAL
  to the official ASM-module-removal replacement pattern
  (terraform-google-kubernetes-engine upgrading_to_v36.0.md) - hub
  feature + membership + feature_membership MANAGEMENT_AUTOMATIC all
  correct, nothing missing on our side. User has NO support plan ->
  file free issue at issuetracker.google.com (component Cloud Service
  Mesh)
- TMP MESH BYPASS deployed to code (uncommitted, build+format green):
  `traffic.sidecar.istio.io/excludeOutboundPorts: "443,3307"` added to
  service.yaml of openfga/authorization/authentication with marker
  comment `# 0010_way_back_home: tmp mesh bypass while TD control
  plane broken, revert after mesh heals`. Bypasses envoy for sqladmin
  API (443) + Cloud SQL data plane (3307) -> DB works with ZERO
  listeners. NOTE: also bypasses mesh for ALL other 443 egress
  (pubsub, googleapis) - acceptable tmp state. Service-to-service
  gRPC 3000/3001 still needs the mesh (mTLS REGISTRY_ONLY) - full
  service mesh traffic remains broken until TD delivers config.
  REVERT: rg 'tmp mesh bypass' in service repos
- sql-proxy image bump ruled out as cause (plain TCP to Google
  frontend; refusal is local envoy RST, not remote)
- checked/ruled out: trafficdirector.googleapis.com ENABLED, CPR exists
  reconciled (asm-managed, 9d), istio-cni DaemonSet healthy (the
  NetworkNotReady events were new-node bootstrap races), istioctl
  proxy-status does not work on TD (no istiod - expected error)
- AFTER staging heals: repeat on dev + production: earth-base td/tp
  apply (EnvoyFilter rewrite + stackdriver removal), DELETE
  grpc-json-transcoder EnvoyFilters in those clusters (kubectl get
  envoyfilter -A), force-reprovision if pushes don't start

UNCOMMITTED WORK SNAPSHOT (2026-08-20):
- earth-base (main): deployments/{dev,staging,production}/main.tf -
  TD-compliant EnvoyFilter rewrite + stackdriver tracing removal
  (staging APPLIED by user; dev+production apply PENDING)
- earth-openfga-service (0010 branch): service.yaml (metadata exclude
  annotation; egress/pipeline/MODULE changes already committed by user)
- earth-authorization-service (0010): service.yaml staged+modified
  (transcoder removal + earlier fixes)
- earth-authentication-service (0010): service.yaml staged+modified
  (transcoder removal + metadata exclude)
- earth-authorization-base + buildkite-base: CLEAN (user committed +
  applied the grants/KSAs)

## WHY TD - ISTIOD vs TRAFFIC_DIRECTOR background (explained to user)

- managed Cloud Service Mesh has 2 control plane implementations:
  ISTIOD (legacy, Google-hosted istiod) and TRAFFIC_DIRECTOR (new,
  meshconfig.googleapis.com xDS). Istio API surface identical
- old us-central1: ASM module created ControlPlaneRevision pinning the
  istiod path -> lenient validation, seconds-fast pushes
- new setup: only `mesh { management = MANAGEMENT_AUTOMATIC }` ->
  Google chooses -> fresh clusters get TRAFFIC_DIRECTOR (confirmed via
  fleet describe `implementation: TRAFFIC_DIRECTOR`). This is Google's
  modernization direction; istiod path being phased out - do NOT try
  to pin legacy istiod, adapt configs instead (one-time cost)
- TD differences that bit us: strict validation (invalid resource can
  block ALL config), extension allowlist for EnvoyFilter, minutes-slow
  propagation, no istiod in cluster (istioctl proxy-status unusable)

## INCIDENT 3b: grpc_json_transcoder EnvoyFilters also rejected by TD (FIXED)

- after the jwt-cookie EnvoyFilter fix was Accepted, fleet still showed
  CONFIG_VALIDATION_ERROR [EnvoyFilter]: the per-service
  `%{service}-grpc-json-transcoder` EnvoyFilters (in service.yaml of
  authorization + authentication services) were the remaining poison.
  grpc_json_transcoder is NOT on TD's extension allowlist (only
  local_ratelimit, grpc_web, compressor, lua) -> fully invalid ->
  rejected -> mesh config blocked. User deleted them from the staging
  cluster -> CONFIG_VALIDATION_ERROR GONE (only the RequestAuth
  warning remains)
- code fix (uncommitted): removed the EnvoyFilter document from
  cmd/*/service.yaml in earth-authorization-service +
  earth-authentication-service (build+format green) so redeploys do
  not re-create them. openfga has none
- USER DECISION: REST/JSON debug endpoints (grpc-json transcoding)
  are wanted back LATER. Options recorded: 1) grpc-gateway in-app,
  2) Google support request to allowlist grpc_json_transcoder,
  3) non-mesh edge envoy. Heal-first for now
- CHECK when migrating remaining stage-5 services: grep service.yaml
  for `grpc-json-transcoder` / any EnvoyFilter and remove/convert
  BEFORE deploying (a single invalid EnvoyFilter kills the whole mesh)
- remaining follow-ups: RequestAuthentication CONFIG_VALIDATION_WARNING
  (check resource status), MISSING_CONTROL_PLANE_CONFIG warning
  (non-blocking, may self-heal)



## INCIDENT 3: mesh-wide egress blackhole - EnvoyFilter unsupported shape on TD (FIXED)

- symptom: since the mesh flipped to TD implementation, ALL egress flaky/
  dead across ALL services incl ingressgateways; sidecars connect to xDS
  + get SDS certs but `istioctl proxy-config listeners` = EMPTY (3 lines)
  -> envoy has NO listener config, REGISTRY_ONLY refuses everything
  (metadata refused pre-bypass, then 443 refused). Intermittent "worked
  a few times" = TD validation state flapping
- root cause via `gcloud container fleet mesh describe` staging:
  CONFIG_VALIDATION_ERROR "Invalid Config Types: [EnvoyFilter]" - the
  TD-based CSM control plane DOES NOT SUPPORT EnvoyFilter. earth-base
  deployed the jwt-cookie-to-authorization-header Lua EnvoyFilter
  (istio-system, all envs) -> whole config application failed
- fix (earth-base, uncommitted): REWROTE the EnvoyFilter TD-compliant
  instead of deleting it (per docs.cloud.google.com/service-mesh/docs/
  data-plane-extensibility TD supports Lua EnvoyFilters with limits):
  1) operation INSERT_BEFORE w/ subFilter jwt_authn -> INSERT_FIRST
     (only INSERT_FIRST, or INSERT_BEFORE against the ROUTER filter,
     are allowed; INSERT_FIRST still runs before jwt_authn = same
     cookie->Authorization semantics)
  2) removed match.listener.portNumber (only listener.filter match
     supported); match is now just context: GATEWAY (lua only acts
     when a jwt cookie exists - safe on all gateway listeners)
  3) inlineCode -> default_source_code.inline_string (only supported
     lua field; script uses no forbidden features - no httpCall/
     filterContext/io/os; <50KB)
  Also removed `tracing: stackdriver` from MeshConfig defaultConfig
  (CONFIG_VALIDATION_WARNING unsupported field). validate+fmt+build
  green all 3 envs. Cookie JWT auth PRESERVED
- TD EnvoyFilter rules (for any future filter): applyTo HTTP_FILTER
  only; INSERT_FIRST or INSERT_BEFORE-router only; no targetRefs/
  filterClass/proxy/routeConfiguration/cluster/portNumber matches;
  lua via default_source_code.inline_string only, no httpCall/
  filterContext/io/debug/ffi, 50KB per script, 100KB + 10 patches per
  cluster; fully-invalid resource = rejected -> can kill whole mesh
  config. After apply: `kubectl get envoyfilter -n istio-system ... -o
  yaml` must show status condition Accepted
- MISSING_CONTROL_PLANE_CONFIG warning: modernization doc says create
  a ControlPlaneRevision only if mesh channel != GKE cluster channel;
  ns labels use istio.io/rev=asm-managed (regular) and autopilot
  cluster channel is regular -> matches, automatic management should
  create the CPR itself; warning is non-blocking ("mesh still working
  but suboptimal"). If it persists after the EnvoyFilter fix, check
  `kubectl get controlplanerevisions -n istio-system` and consider
  the doc's step 4 manually

## INCIDENT 2: openfga staging still failing after MeshConfig fix (FIXED in code)

- symptom (logs4.csv): cloud-sql-proxy fetches connectSettings fine (443 +
  metadata egress OK) but every dial to 172.17.0.2:3307 dies during TLS
  handshake with EOF / "connection reset by peer" -> openfga migrate
  "invalid connection" crash loop
- root cause: cmd/<svc>/egress.yaml mysql ServiceEntry reused host
  `sqladmin.googleapis.com`, which the first ServiceEntry already defines
  with resolution DNS on 443. Istio merges same-host ServiceEntries
  (cross-resource semantics undefined); new CSM control plane programs the
  DNS/443 definition and drops the addresses+3307 TCP passthrough ->
  REGISTRY_ONLY blackholes 3307. Old us-central1 istiod happened to order
  it favorably (same yaml worked for years with 10.79.x/10.91.x IPs)
- evidence: the other two ServiceEntries in the same file DO work
  (metadata 169.254.169.254 STATIC, googleapis 443 DNS) - only the
  duplicate-host one is dead. envoy accepts the TCP connect locally then
  resets = classic blackhole/mis-route signature
- fix (earth-openfga-service, uncommitted): mysql ServiceEntry now has
  unique host `mysql.google.internal` + `resolution: STATIC` +
  `endpoints: [address: %{dbPrivateIp}]` - exact shape of the
  proven-working metadata entry. build/test/format green
- RULE for the other 16 stage-5 repos: NEVER reuse a hostname across
  ServiceEntries; copy the fixed egress.yaml from openfga
- DEPLOY ORDERING: user deploys manually via `mmfd` from ~/.functions
  (NEVER edit user dotfiles!) whose order is already correct:
  oci_push -> auth -> egress -> ingressgateway (non-openfga) -> service.
  The PIPELINE however had service -> auth -> egress; fixed to
  oci_push -> egress -> auth -> service in all 3 envs (uncommitted) as
  hardening for the not-yet-used pipeline deploys. Apply same order in
  every stage-5 service pipeline. DONE: openfga (egress->auth->service),
  authentication (egress->auth->ingressgateway->service, all 3 envs,
  uncommitted; //:format + build + test green per its AGENTS.md).
  authentication egress.yaml needed NO host fix (no sql SE, no duplicate
  hosts). TODO for remaining 15 repos: 1) egress.yaml duplicate-host
  check (any repo with a mysql/redis SE reusing sqladmin.googleapis.com
  -> unique host + STATIC + endpoints like openfga), 2) pipeline kubectl
  order service LAST
- REAL first-deploy failure cause (fresh namespace, correct mmfd order):
  managed CSM (Traffic Director via meshconfig.googleapis.com) needs
  minutes to propagate NEW ServiceEntries to sidecars; pods started
  right after apply get blackholed (metadata refused + 3307 EOF) and
  the migrate Fatal crashloops. A second deploy later (new sum -> new
  ReplicaSet after TD propagated) comes up clean. Expect this once per
  fresh env/namespace for every stage-5 service - just redeploy or
  `kubectl rollout restart` after a few minutes, no config change needed
- staging WORKS now (user confirmed) after egress unique-host fix +
  second deploy; user also staged an openfga image digest bump in
  MODULE.bazel
- authentication-service vars.bzl mangle FIXED (uncommitted): rename
  branch left `-dev-382708-504915` / `-staging-382708-504915` in
  deployments/{dev,staging}/vars.bzl -> broke impersonation
  (earth-authentication-s-d@earth-dev-382708-504915 Gaia not found).
  Fixed to -dev-504915/-staging-504915; production was correct. SAME
  concatenation gotcha as billingstripe-config - grep '382708' in every
  remaining stage-5 repo before deploying
- CLOUD SQL PROXY IMAGE PIN (user bumped in openfga service.yaml,
  apply to EVERY stage-5 repo with a cloud-sql-proxy sidecar):
  gcr.io/cloud-sql-connectors/cloud-sql-proxy@sha256:a6eab4b8c0e9da72c04a9456100ddafdeef076561e2569edcaede3e6d248d3eb
  (replaces old sha256:fc224915ef435afeb5b2a9421260a0d31986d5c8b7c7f5783c7f5d5885700cd2).
  authentication-service has no sql sidecar - n/a there
- openfga dev:master not working while dev:loeffel-io works: config is
  identical per dev (same ip/db pattern); suspected old SE still in
  earth-openfga-service-master ns (egress only redeployed for
  loeffel-io) or TD propagation lag; else check per-dev db/iam grants

## stage 5: earth-authorization-service DONE (uncommitted)

- branch chore/loeffel-io/0010 based on origin/chore/loeffel-io/0009
  (latest 00XX branch, 5 ahead of main - per authentication lesson).
  GOTCHA: `git checkout -b X origin/Y` sets upstream to origin/Y ->
  push fails. Use `--no-track` when branching from another remote
  branch, or fix with `git branch --unset-upstream && git push -u`
  (done here - branch pushed)
- has AGENTS.md: tidy = `bazel run @rules_go//go -- mod tidy && bazel run
  //:gazelle && bazel mod tidy`, format = //:format (repo ALSO has
  //tools/format:format.check for the pipeline)
- full recipe applied: vars.bzl europe-west3 + -504915 (all 3 envs, was
  clean old ids, no 382708 mangle), MODULE.bazel+go.mod pins (rules
  v0.23.3, global_proto 2.25.0, authorization-proto 1.0.2, user-proto
  1.0.3, user-internal 1.0.3), image.bzl -eu-1 (BOTH image paths - repo
  has 2nd container earth-authorizationauthorization-service, an envoy
  ext-authz sidecar image), dbHost -eu-1, dbPrivateIp 172.17.0.12 all
  envs, egress.yaml mysql SE unique-host fix, cloud-sql-proxy digest
  a6eab4b8, production BUILD blocks replicated (domain apex
  authorization.mindful.com), deployments/production/BUILD.bazel
  replicated from staging, pipeline agent-stack-k8s with egress->auth->
  ingressgateway->service order + dev env MINDFUL_USER=master +
  MINDFUL_USER_OPENFGA_STORE_ID=01K7CMPKW9VHM6PTHVZBH2KT1B +
  MINDFUL_USER_OPENFGA_AUTHORIZATION_MODEL_ID=01KWHMZ2G000KBETN2P31NYXDP
  (carried over from old pipeline; --define flags on every dev command)
- SPECIAL vs openfga: redis cluster SE (redis.cluster.internal
  10.0.0.240/29 resolution NONE) + sidecar annotation
  excludeOutboundIPRanges 10.0.0.240/29 - subnet correct per earth-base.
  redisAddr set per README redis info: dev 10.0.0.243, staging
  10.0.0.242, production 10.0.0.243 (:6379). pubsub (user-events-v1
  subscription), proto descriptor-set configmap targets, 2 oci_push
  targets per env
- REDIS PSC ALLOCATION GOTCHA (from README redis data): billingstripe
  redis endpoints are dev/staging 10.0.0.244, production 10.0.0.245 -
  INSIDE the authorization subnet 10.0.0.240/29, NOT billingstripe's
  10.0.0.248/29 (SCP allocates from any of its subnets). When migrating
  earth-billingstripe-service: its egress SE / excludeOutboundIPRanges
  subnet must COVER the actual endpoint (use 10.0.0.240/29 or both
  subnets), else redis traffic gets blackholed
- production service template carries the NEW openfga ids from README
  (staging store 01M0EVFRCQW64Z3XWZGFKVM3Y9 / model
  01M0EVGBSGY1DSMGC06VJJS5K8; production store 01M0AJQP4RNMQYJMKFS97A57TM
  / model 01M0AJRHEDFDAJQFGGKYZ66GQZ; loeffel-io ids in README come via
  MINDFUL_USER rc). loggerDevelopment still True in production (staging
  parity, user may flip later). PIPELINE dev env still has the OLD
  master ids (01K7CMPKW9VHM6PTHVZBH2KT1B / 01KWHMZ2G000KBETN2P31NYXDP) -
  README says master store/model = MISSING; update pipeline.yml once
  user seeds the master store
- cross-repo: earth-authorization-base (main, uncommitted) grants on
  SERVICE gsa all 3 envs; buildkite-base (main, uncommitted)
  earth_authorization_service_{dev,staging,production}.tf + BUILD
  entries. validate green everywhere (tp/td/ts + buildkite tp)
- verification: mod tidy+gazelle+bazel mod tidy, build+test+format
  green; expanded production template verified (project/AR/-eu-1/ip)
- remaining: user apply authorization-base (3 envs) -> buildkite-base tp
  -> buildkite UI cluster switch -> merge -> tag
- rollout: merge -> staging deploy applies SE (same name, kubectl apply
  overwrites); with the new egress-first pipeline order fresh deploys
  work in one pass

## INCIDENT: staging mesh broken - invalid MeshConfig field (FIXED in code)

- symptom: openfga staging pod up but cloud-sql-proxy could not reach
  metadata server (169.254.169.254 connection refused), mysql EOF loop,
  istio-proxy "Traffic Director configuration was not found for mesh ..."
- root cause via `gcloud container fleet mesh describe`:
  CONFIG_VALIDATION_ERROR - istio-asm-managed ConfigMap MeshConfig has
  `includeRequestHeadersInCheck` under envoyExtAuthzGrpc. That field only
  exists on envoyExtAuthzHttp (grpc always sends all headers). Old
  us-central1 istiod tolerated unknown fields; the NEW TD implementation
  strictly validates and rejects the ENTIRE MeshConfig -> no xDS -> sidecars
  black-hole ALL egress incl metadata server
- fix: removed the field from earth-base main.tf ALL 3 envs (dev+prod had
  it too - same latent bomb). validate green. user must apply td/ts/tp,
  then `kubectl rollout restart deployment -n <ns>` for affected workloads
  (or wait for mesh to re-push after configmap update)
- also seen (WARNING only): MISSING_CONTROL_PLANE_CONFIG - modernization
  config per docs link; mesh works, address later
- LESSON: `gcloud container fleet mesh describe` is the first diagnostic
  for mesh-wide egress failures; terraform "no changes" does NOT mean the
  mesh accepted the config
