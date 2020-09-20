#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

readonly proj_dir=$(cd "$(dirname "$0")/.."; pwd)

readonly files=(
    "$proj_dir"/lib/src/**.c
    "$proj_dir"/lib/src/**.h
    "$proj_dir"/lib/src/**.cpp
    "$proj_dir"/lib/src/**.hpp
    "$proj_dir"/lib/include/**.h
    "$proj_dir"/lib/include/**.hpp
    "$proj_dir"/test/src/**.c
    "$proj_dir"/test/src/**.h
    "$proj_dir"/test/src/**.cpp
    "$proj_dir"/test/src/**.hpp
)

clean='false'

while [ $# -gt 0 ]; do
    key="$1"

    case $key in
        -c|--clean)
        clean='true'
        shift
        ;;
        -*|--*)
        echo "Unknown option $key"
        exit 1
        ;;
        *)
        echo "Invalid argument $key"
        exit 1
        ;;
    esac
done

if [ "$clean" = 'true' ]; then
    rm -fr "$proj_dir/build_tidy"
fi
mkdir -p "$proj_dir/build_tidy"
cd "$proj_dir/build_tidy"

cmake "$proj_dir" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DTIDY_MODE=ON
cmake --build .

clang-tidy-11 -p . ${files[@]}
