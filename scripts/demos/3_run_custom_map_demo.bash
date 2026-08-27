#!/usr/bin/env bash

docker container stop ros2_rust_nav2_tb4_sim_c
docker container rm ros2_rust_nav2_tb4_sim_c

xhost +local:docker

docker run -it --rm \
--name ros2_rust_nav2_tb4_sim_c \
--network host \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
-e RMW_IMPLEMENTATION=rmw_zenoh_cpp \
--device=/dev/dri \
-v ./scripts/assets/simple_map.yaml:/ros2/simple_map.yaml \
-v /tmp/.X11-unix:/tmp/.X11-unix \
ros2_rust_nav2_tb4_sim:jazzy bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch rmf_path_server_demo demo_map.launch.py planner:=ccbs map_file:=/ros2/simple_map.yaml"