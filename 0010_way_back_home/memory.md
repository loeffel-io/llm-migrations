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
| earth-openfga-base | chore/loeffel-io/0010 | STAGE 3 DONE (repo + buildkite-base KSAs + earth-base WI grants). Reminder: manual buildkite UI cluster switch |
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
- earth-base (all envs) `subdomains` NS record rrdatas carry copied/old
  nameserver values - real values only known after stage 3 child zones exist
  (README: "earth-base DONE - ns missing")

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
- WORKSPACE rules pin: ALL workspace repos must use
  `com_github_mindful_hq_rules` tag v0.19.11 (required for the stage-3
  buildkite/ksa flow); bumped everywhere in stage 1+2
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
  marked with 0010 comment)
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

## stage 3 per-repo checklist (established with earth-openfga-base)

1. repo itself: full recipe (was already done for openfga during stage 2 work)
2. buildkite-base: add `earth_<svc>_base_{dev,staging,production}.tf` KSA files
   (fake-gsa pattern, locals from locals.tf, ns `buildkite`, KSA name full-form
   `earth-<svc>-base-<env>` == pipeline serviceAccountName, GSA email short
   `earth-<svc>-base-<e>@earth-<env>-504915`); add files to BUILD.bazel
3. earth-base: append `google_service_account_iam_member` grant
   (`roles/iam.serviceAccountAdmin` for
   `buildkite-base-p@buildkite-504915.iam.gserviceaccount.com`, SA-level,
   0010 comment) to each env's `earth_<svc>_base.tf` - earth-base has no
   buildkite vars, member is inline
4. remind user: manual buildkite UI cluster switch for the pipeline
5. apply order: earth-base (grants) -> buildkite-base (KSAs) -> repo pipeline
- done for openfga: buildkite-base earth_openfga_base_{dev,staging,production}.tf,
  earth-base earth_openfga_base.tf grants (all envs), all validate/bazel green
