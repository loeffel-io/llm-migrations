#!/usr/bin/env bash
# 0008: apply global-proto v2.23.0 migration (patch.diff) to a service proto repo
set -euo pipefail
cd "$1"

echo "8.6.0" >.bazelversion

if ! grep -q 'incompatible_enable_proto_toolchain_resolution' .bazelrc; then
	cat >>.bazelrc <<'EOF'

# prebuilt protobuf
# remove after bazel 9 migration and https://github.com/bazel-contrib/rules_go/issues/4587
build --incompatible_enable_proto_toolchain_resolution
build --per_file_copt=external/.*protobuf.*@-DPROTOBUF_WAS_NOT_SUPPOSED_TO_BE_BUILT
build --host_per_file_copt=external/.*protobuf.*@-DPROTOBUF_WAS_NOT_SUPPOSED_TO_BE_BUILT
build --per_file_copt=external/.*grpc.*@-DGRPC_WAS_NOT_SUPPOSED_TO_BE_BUILT
EOF
fi

sed -i '' \
	-e '/bazel_dep(name = "rules_proto", version = /d' \
	-e '/bazel_dep(name = "rules_python", version = /d' \
	-e 's/\(name = "rules_go", version = "\)[^"]*/\10.59.0/' \
	-e 's/\(name = "gazelle", version = "\)[^"]*/\10.44.0/' \
	-e 's/\(name = "rules_nodejs", version = "\)[^"]*/\16.6.2/' \
	-e 's/\(name = "aspect_rules_js", version = "\)[^"]*/\12.8.3/' \
	-e 's/\(name = "rules_proto_grpc_doc", version = "\)[^"]*/\15.8.0/' \
	-e 's/\(name = "aspect_rules_lint", version = "\)[^"]*/\11.10.2/' \
	-e 's/\(name = "aspect_bazel_lib", version = "\)[^"]*/\12.22.5/' \
	-e 's/\(name = "bazel_skylib", version = "\)[^"]*/\11.9.0/' \
	-e 's/\(name = "rules_pkg", version = "\)[^"]*/\11.2.0/' \
	-e 's/\(name = "protobuf", version = "\)[^"]*/\134.1/' \
	-e 's/\(name = "rules", version = "\)[^"]*/\10.23.2/' \
	-e 's/\(name = "global_proto", version = "\)[^"]*/\12.23.0/' \
	-e 's/\(go_sdk\.download(version = "\)[^"]*/\11.26.2/' \
	MODULE.bazel

perl -0pi -e 's/(module_name = "rules",\n    remote = "git\@github\.com:mindful-hq\/rules\.git",\n    tag = ")v[^"]*/${1}v0.23.2/' MODULE.bazel
perl -0pi -e 's/(module_name = "global_proto",\n    remote = "git\@github\.com:mindful-hq\/global-proto\.git",\n    tag = ")v[^"]*/${1}v2.23.0/' MODULE.bazel
perl -0pi -e 's/\ngit_override\(\n    module_name = "rules_python",.*?\n\)\n//s' MODULE.bazel

sed -i '' \
	-e 's/^go 1\..*/go 1.26.2/' \
	-e 's|\(github\.com/mindful-hq/global-proto/v2 \)v[0-9A-Za-z.-]*|\1v2.23.0|' \
	go.mod

if [ -f package.json ]; then
	sed -i '' 's|\("@global-proto-production/global-proto": "\)[^"]*|\1^2.23.0|' package.json
fi

if [ -f pubspec.yaml ]; then
	perl -0pi -e 's/(global_proto:\n    version: )\^[0-9.]+/${1}^2.23.0/' pubspec.yaml
fi

if [ -f build/buildkite/pipeline.yml ]; then
	sed -i '' 's|sha256:3a858aeb09abeb19f41f888a7471e8869229d7b231370eb3d3793794863928a0|sha256:503e0797a9f8a2a96ca478b8239043b8d980bf0ab94136f5242429b2af950bf4|' build/buildkite/pipeline.yml
fi

grep -rl --include=BUILD.bazel 'load("@rules_proto//proto:defs.bzl"' . 2>/dev/null | while read -r f; do
	perl -0pi -e 's|load\("\@rules_proto//proto:defs\.bzl", "proto_descriptor_set", "proto_library"\)|load("\@protobuf//bazel:proto_descriptor_set.bzl", "proto_descriptor_set")\nload("\@protobuf//bazel:proto_library.bzl", "proto_library")|g' "$f"
	perl -0pi -e 's|load\("\@rules_proto//proto:defs\.bzl", "proto_descriptor_set"\)|load("\@protobuf//bazel:proto_descriptor_set.bzl", "proto_descriptor_set")|g' "$f"
done

go mod tidy
