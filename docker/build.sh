#!/bin/bash

readonly OCI_REPOSITORY=$1
readonly BAZEL_VERSION=$2

set -o errexit -o nounset -o pipefail

function print_usage() {
    >&2 echo "Usage: $0 <OCI_REPOSITORY> <BAZEL_VERSION>"
}

if [ -z "${OCI_REPOSITORY}" ]; then
    >&2 echo "ERROR: missing 'OCI_REPOSITORY' argument"
    print_usage
    exit 1
fi

if [ -z "${BAZEL_VERSION}" ]; then
    >&2 echo "ERROR: missing 'BAZEL_VERSION' argument"
    print_usage
    exit 1
fi

GIT_ROOT=$(git rev-parse --show-toplevel)
readonly GIT_ROOT

if docker buildx version &>/dev/null; then
    buildx="buildx"
fi

# 実行
docker-compose up