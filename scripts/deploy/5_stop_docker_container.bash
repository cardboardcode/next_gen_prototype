#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="ros2_rust_nav2_tb4_sim_c"

docker container stop $CONTAINER_NAME
docker container rm $CONTAINER_NAME

unset CONTAINER_NAME
