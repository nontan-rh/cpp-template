#!/bin/bash

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

clang-format-11 -i ${files[@]}
