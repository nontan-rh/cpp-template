#!/bin/bash

set -euo pipefail
shopt -s nullglob

readonly proj_dir=$(cd "$(dirname "$0")/.."; pwd)

readonly files=(
    "$proj_dir"/cmake/**
    "$proj_dir"/docker/**
    "$proj_dir"/etc/**
    "$proj_dir"/lib/**
    "$proj_dir"/script/**
    "$proj_dir"/test/**
    "$proj_dir"/CMakeLists.txt
    "$proj_dir"/README.md
)

status=0

check() {
    for file in "$@"; do
        set +e
        npx cspell $file
        file_status=$?
        set -e
        if [ $file_status != 0 ]; then
            status=1
        fi
    done
}

for file in "${files[@]}" ; do
    check "$file"
done

exit $status
