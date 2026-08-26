#!/usr/bin/env bash

docker container stop ros2_rust_nav2_tb4_sim_c
docker container rm ros2_rust_nav2_tb4_sim_c

xhost +local:docker

docker run -it --rm \
    --name ros2_rust_nav2_tb4_sim_c \
    --gpus all \
    --network host \
    --env DISPLAY="${DISPLAY}" \
    --env QT_X11_NO_MITSHM=1 \
    --env XDG_RUNTIME_DIR=/tmp/runtime-root \
    --env NVIDIA_VISIBLE_DEVICES=all \
    --env NVIDIA_DRIVER_CAPABILITIES=all \
    --env __GLX_VENDOR_LIBRARY_NAME=nvidia \
    --env LIBGL_ALWAYS_INDIRECT=0 \
    --env CYCLONEDDS_URI=/ros2_ws/cyclonedds.xml \
    --env RMW_IMPLEMENTATION=rmw_cyclonedds_cpp \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v ./scripts/assets/simple_map.sdf:/opt/ros/jazzy/share/nav2_minimal_tb4_sim/worlds/simple_map.sdf \
    -v ./scripts/assets/simple_map.pgm:/nav2_traffic_ws/install/sp_demo_nav2_bringup/share/sp_demo_nav2_bringup/maps/simple_map.pgm \
    -v ./scripts/assets/simple_map.yaml:/nav2_traffic_ws/install/sp_demo_nav2_bringup/share/sp_demo_nav2_bringup/maps/simple_map.yaml \
    -v ./cyclonedds.xml:/ros2_ws/cyclonedds.xml \
    -v ./scripts/custom_cloned_multi_tb3_simulation_launch.py:/nav2_traffic_ws/install/sp_demo_nav2_bringup/share/sp_demo_nav2_bringup/launch/custom_cloned_multi_tb3_simulation_launch.py \
    -v "./scripts/assets/gcache:/root/.gz/fuel/fuel.gazebosim.org/openrobotics/models/" \
ros2_rust_nav2_tb4_sim:jazzy \
    bash -c "source /nav2_traffic_ws/install/setup.bash && \
    ros2 launch sp_demo_nav2_bringup custom_cloned_multi_tb3_simulation_launch.py \
    robots:=\"robot0={x: -0.558153510093689, y: -1.112405293062329292, yaw: 0.0}; \
    robot1={x: -0.558153510093689, y: 0.712405293062329292, yaw: 0.0};\""