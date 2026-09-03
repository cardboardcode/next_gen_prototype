#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="ros2_rust_base_c"

docker container stop $CONTAINER_NAME
docker container rm $CONTAINER_NAME

unset CONTAINER_NAME
