#!/usr/bin/env bash

set -euo pipefail

proj_dir=$(cd "$(dirname "$0")/.."; pwd)

rm -fr "$proj_dir/build"
mkdir -p "$proj_dir/build"
cd "$proj_dir/build"

cmake .. "$@"
cmake --build .
ctest --verbose
