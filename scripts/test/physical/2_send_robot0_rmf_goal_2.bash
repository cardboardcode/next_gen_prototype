#!/usr/bin/env bash

docker exec ros2_rust_nav2_tb4_sim_c bash -c "source /opt/ros/jazzy/setup.bash && ros2 action send_goal robot0/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
      pose: {
        header: {
          stamp: {sec: 0, nanosec: 0},
          frame_id: 'map'
        },
        pose: {
          position: {x: -0.5801073908805847,y: 0.25394144654273987,z: 0.0},
          orientation: {x: 0.0,y: 0.0,z: 0.01369471467804565,w: 0.9999062229978803}
        }
      }
    }\"
"
