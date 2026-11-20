#!/usr/bin/env bash

IMAGE_NAME="ngp_build:jazzy"
CONTAINER_NAME="ngp_build_jazzy_c"

container_exists() {
    docker ps -a --format '{{.Names}}' 2>/dev/null | grep -Eq "^${1}\$"
}

# Check if the container already exists
if container_exists "$CONTAINER_NAME"; then
    read -r -p "Container '$CONTAINER_NAME' already exists. Do you want to do a clean build? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        echo "Removing existing container '$CONTAINER_NAME'..."
        docker rm -f "$CONTAINER_NAME"
    fi
fi

if container_exists "$CONTAINER_NAME"; then
    echo "Starting existing container '$CONTAINER_NAME'..."
    docker start -ai "$CONTAINER_NAME"
else
    docker run -it \
        --name "$CONTAINER_NAME" \
    "$IMAGE_NAME" \
        bash -c '
    rosdep install --from-paths /tmp/next_gen_prototype --rosdistro ${ROS_DISTRO} \
    --ignore-src -yr --skip-keys="rclrs ament_cargo ament_python" && \
    . /opt/ros/${ROS_DISTRO}/setup.sh && \
    mkdir src && mv /tmp/next_gen_prototype /nav2_traffic_ws/src/next_gen_prototype && \
    colcon build \
    --mixin release lld \
    --cmake-args \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_BUILD_TYPE=Release && \
    echo "==================================================" && \
    echo "                 CCACHE STATS (BUILD)               " && \
    echo "==================================================" && \
    ccache -s && \
    echo "==================================================" && \
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc && \
    echo "source /nav2_traffic_ws/install/setup.bash" >> /etc/bash.bashrc
    '
fi
