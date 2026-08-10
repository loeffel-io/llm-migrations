#!/usr/bin/env bash
# 0009: run verification pipeline in a service repo
set -euo pipefail
cd "$1"
bazel run @rules_go//go -- mod tidy
bazel run //:gazelle
bazel mod tidy
bazel build //...
bazel test //...
bazel run //:format
echo "PIPELINE_OK $1"
