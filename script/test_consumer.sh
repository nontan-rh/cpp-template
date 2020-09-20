#!/usr/bin/env bash

set -euo pipefail

readonly proj_dir=$(cd "$(dirname "$0")/.."; pwd)
readonly prefix_dir="$proj_dir/build_consumer/local"

rm -fr "$proj_dir/build"
rm -fr "$proj_dir/build_consumer"

mkdir -p "$proj_dir/build"
mkdir -p "$proj_dir/build_consumer"
mkdir -p "$prefix_dir"

cd "$proj_dir/build"

cmake .. "$@" -DCMAKE_INSTALL_PREFIX="$prefix_dir"
cmake --build .
cmake --build . --target install

cd "$proj_dir/build_consumer"

cmake ../etc/test/consumer -DCMAKE_PREFIX_PATH="$prefix_dir" -DCMAKE_FIND_DEBUG_MODE=ON
cmake --build .
