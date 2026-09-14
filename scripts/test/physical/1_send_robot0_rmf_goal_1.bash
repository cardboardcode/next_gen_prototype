#!/usr/bin/env bash

docker exec ros2_rust_nav2_tb4_sim_c bash -c "source /opt/ros/jazzy/setup.bash && ros2 action send_goal robot0/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
      pose: {
        header: {
          stamp: {sec: 0, nanosec: 0},
          frame_id: 'map'
        },
        pose: {
          position: {x: -0.924168050289154,y: 1.5128917694091797,z: 0.0},
          orientation: {x: 0.0,y: 0.0,z: -0.7062440014957007, w: 0.7079685094348058}
        }
      }
    }\"
"
