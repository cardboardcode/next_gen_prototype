#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="ros2_rust_nav2_tb4_sim_c"

docker logs $CONTAINER_NAME --tail 1000 -f

unset CONTAINER_NAME
