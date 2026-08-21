#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="next_gen_prototype_c"
IMAGE_NAME="next_gen_prototype:jazzy_nav2"

# 1. Stop and remove the container only if it already exists
if [ "$(docker ps -aq -f name="^${CONTAINER_NAME}$")" ]; then
    echo "Cleaning up existing container: ${CONTAINER_NAME}..."
    docker rm -f "${CONTAINER_NAME}" > /dev/null
fi

# 2. Run the new container with proper line continuation
echo "Launching Next-Gen-Prototype Open-RMF RMF Stack..."
docker run -it --rm \
    --name "${CONTAINER_NAME}" \
    --gpus all \
    --network host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/dri \
    "${IMAGE_NAME}" bash -c "
        source /nav2_traffic_ws/install/setup.bash && \
        ros2 launch rmf_path_server_demo demo_nav2.launch.py robots:='robot0 robot1'
    "
