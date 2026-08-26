#!/usr/bin/env bash

docker container stop ros2_rust_nav2_tb4_sim_c
docker container rm ros2_rust_nav2_tb4_sim_c

xhost +local:docker

docker run -it --rm \
--name ros2_rust_nav2_tb4_sim_c \
--gpus all \
--network host \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--device=/dev/dri \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ./scripts/cloned_multi_tb3_simulation_launch.py:/nav2_traffic_ws/install/sp_demo_nav2_bringup/share/sp_demo_nav2_bringup/launch/cloned_multi_tb3_simulation_launch.py \
-v ./scripts/demo_nav2.launch.py:/nav2_traffic_ws/install/rmf_path_server_demo/share/rmf_path_server_demo/launch/demo_nav2.launch.py \
ros2_rust_nav2_tb4_sim:jazzy bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch sp_demo_nav2_bringup cloned_multi_tb3_simulation_launch.py robots:=\"robot0={x: 0.0, y: 5.0, yaw: 0.0}; robot1={x: 3.0, y: 5.0, yaw: 0.0};\""

# bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch sp_demo_nav2_bringup cloned_multi_tb3_simulation_launch.py robots:=\"robot0={x: 0.0, y: 5.0, yaw: 0.0}; robot1={x: 3.0, y: 5.0, yaw: 0.0};\""

# bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch sp_demo_nav2_bringup cloned_multi_tb3_simulation_launch.py robots:=\"robot0={x: 0.0, y: 5.0, yaw: 0.0};\""