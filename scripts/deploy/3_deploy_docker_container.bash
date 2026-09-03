#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="ros2_rust_nav2_tb4_sim_c"
IMAGE_NAME="ros2_rust_nav2_tb4_sim:jazzy"

# 1. Stop and remove the container only if it already exists
if [ "$(docker ps -aq -f name="^${CONTAINER_NAME}$")" ]; then
    echo "Cleaning up existing container: ${CONTAINER_NAME}..."
    docker rm -f "${CONTAINER_NAME}" > /dev/null
fi

# 2. Run the new container with proper line continuation
echo "Launching Next-Gen-Prototype Open-RMF RMF Stack..."
docker run -it -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    --network host \
    --env RMW_IMPLEMENTATION=rmw_cyclonedds_cpp \
    "${IMAGE_NAME}" bash -c "
        source /nav2_traffic_ws/install/setup.bash && \
        ros2 launch rmf_path_server_demo demo_nav2.launch.py"
