#!/usr/bin/env bash

set -euo pipefail

docker exec -it next_gen_prototype_c bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 launch rmf_path_server_demo demo_nav2.launch.py robots:=\"robot0 robot1\""
