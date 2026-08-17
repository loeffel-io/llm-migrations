# 0010_way_back_home - migration memory

Working memory for the us-central1 -> europe-west3 migration. Read together
with README.md (rules, stages, db sizing). Keep this file updated after every
repo migration.

## status (as of last session)

| repo | branch | state |
|---|---|---|
| base | chore/loeffel-io/0010 | DONE incl buildkite split (user committed: buildkite_base_production.tf, global_base_production.tf, multi-project vars.bzl). No pipeline.yml by design (bootstrap) |
| global-base | chore/loeffel-io/0010 | DONE incl pipeline agent-stack-k8s + v0.9.0 refs + bazel 6.6.0 |
| earth-base | chore/loeffel-io/0010 | DONE (dev+staging+production, pipeline, v0.9.0, bazel 6.6.0) - NS rrdatas lazy (stage 3) |
| buildkite-base | chore/loeffel-io/0010 | DONE (cluster/nat/ksa/helm + foreign KSAs for global-base-production, earth-base-dev/staging/production in own tf files, fake-gsa pattern, ns buildkite) |
| buildkite (old repo) | - | legacy us-central1 repo, superseded by buildkite-base, do not touch |
| earth-openfga-base | chore/loeffel-io/0010 | STAGE 3 DONE + applied by user (repo, buildkite-base KSAs, earth-base WI grants, UI cluster switch, rules v0.19.11) |
| earth-authorization-base | chore/loeffel-io/0010 | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, ZONAL+MYSQL_8_4, UI cluster switched) |
| earth-iam-base | chore/loeffel-io/0010 | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, ZONAL+MYSQL_8_4, prod db-g1-small). Needs: user apply + UI cluster switch |
| earth-user-base | chore/loeffel-io/0010 | STAGE 3 DONE (full recipe, production replicated, proto+internal-proto tf, KSAs, grants). Needs: user apply + UI cluster switch |
| earth-authentication-base | chore/loeffel-io/0010 (BASED ON auth-to-authentication BRANCH, not main!) | STAGE 3 DONE incl .bazelrc (pushed) + 63-char bucket fix (uncommitted). earth-base earth_auth_base.tf removed (uncommitted there) |
| earth-content-base | chore/loeffel-io/0010 | STAGE 3 DONE (full recipe, production replicated, proto tf, KSAs, grants, .bazelrc; prod db-custom-1-3840; bucket lengths ok). Needs: user apply + UI cluster switch |
| earth-resourcemanager-base | chore/loeffel-io/0010 | STAGE 3 DONE (prod db-custom-1-3840; proto bucket 63-char substr fix) |
| earth-email-base | chore/loeffel-io/0010 | STAGE 3 DONE (2 services: email+emailmailgun; MAILGUN provider wgebis/mailgun 0.7.7 must stay in versions.tf; prod db-g1-small; internal-proto bucket 63-char fix) |
| earth-billing-base | chore/loeffel-io/0010 | STAGE 3 DONE (4 units: billing+billingrevenuecat+billingstripe+billingstripe-config; billingstripe has redis -eu-1; prod db-custom-1-3840; revenuecat-proto + billing-internal-proto bucket 63-char fixes) |
| earth-storage-base | chore/loeffel-io/0010 | STAGE 3 DONE (prod db-custom-1-3840; RAW google_storage_bucket data buckets -> -eu-1 + location US->EU, missed initially) |
| earth-website-base | chore/loeffel-io/0010 | STAGE 3 DONE (no sql/proto; single service) |
| earth-language-base | chore/loeffel-io/0010 | STAGE 3 DONE (proto tf w/ hub+app+website readers commented; GSA short-name fix was MISSED in batch, caught by user apply error: account_id >30 chars - fixed service/impl/proto to earth-language-s-<e> pattern) |
| earth-hub-base | chore/loeffel-io/0010 | STAGE 3 DONE (no sql/proto) |
| earth-app-base | chore/loeffel-io/0010 | STAGE 3 DONE (earth_app.tf firebase apple/android apps; production ids staging->com.mindful.appx, SHA HASHES COPIED FROM STAGING - user must replace with production signing certs; commented google-play-notifications gsa block left as-is uncommitted-by-user) |
| earth-billingstripe-config | chore/loeffel-io/0010 | DONE + APPLIED BY USER all envs (full recipe; no gcloud resources of its own - stripe products/prices/portal/webhooks; production main.tf replicated from staging w/ apex domains billingstripe.mindful.com + app.mindful.com; KEEP stripe/stripe + lukasaron/stripe (stripe-third-party) 3.4.1 providers; dev pipeline needs MINDFUL_USER=master + MINDFUL_USER_REVENUECAT_APP_ID=app24d412ed4b as container env in podSpec; its GSA earth-billingstripe-c-<e> is OWNED BY earth-billing-base earth_billingstripe_config.tf -> serviceAccountAdmin grants added THERE (not earth-base); buildkite-base KSA files earth_billingstripe_config_{dev,staging,production}.tf added; stripe resources imported into new state - see stripe import section). Remaining: user UI cluster switch + archive orphaned duplicate stripe products/webhooks |
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
| earth-user-service-proto | v1.0.2 |
| earth-user-service-internal-proto | v1.0.2 |
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
