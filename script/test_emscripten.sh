#!/bin/bash

set -euo pipefail

readonly proj_dir=$(cd "$(dirname "$0")/.."; pwd)

/emsdk/emsdk activate latest
. /emsdk/emsdk_env.sh

rm -fr "$proj_dir/build"
mkdir -p "$proj_dir"/build
cd "$proj_dir"/build

emcmake cmake .. "$@"
cmake --build .

readonly test_driver_dir="$proj_dir/etc/test/wasm/test_driver"
npm install --prefix "$test_driver_dir"

readonly old_pwd=$(pwd)
cd etc/test/standalone
python3 -m http.server 8080 &
http_server_pid=$!
cd "$old_pwd"

stop_server() {
    kill -9 $http_server_pid
}
trap stop_server EXIT

npm start --prefix "$test_driver_dir" -- --no-sandbox
