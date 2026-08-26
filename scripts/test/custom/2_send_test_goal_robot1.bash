#!/usr/bin/env bash

docker exec ros2_rust_nav2_tb4_sim_c bash -c "source /nav2_traffic_ws/install/setup.bash && ros2 action send_goal robot1/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
      pose: {
        header: {
          stamp: {sec: 0, nanosec: 0},
          frame_id: 'map'
        },
        pose: {
          position: {x: -0.558153510093689, y: 0.512405293062329292, z: 0.0},
          orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
        }
      }
    }\"
"