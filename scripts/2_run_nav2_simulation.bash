#!/usr/bin/env bash

docker container stop next_gen_prototype_c
docker container rm next_gen_prototype_c

xhost +local:docker

docker run -it --rm \
--gpus all \
--network host \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--device=/dev/dri \
--name next_gen_prototype_c \
next_gen_prototype:jazzy_nav2 bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch sp_demo_nav2_bringup cloned_multi_tb3_simulation_launch.py   robots:=\"robot0={x: 0.0, y: 5.0, yaw: 0.0}; robot1={x: 3.0, y: 5.0, yaw: 0.0};\""

