#!/usr/bin/env bash

docker exec ros2_rust_nav2_tb4_sim_c bash -c "source /opt/ros/jazzy/setup.bash && ros2 action send_goal robot1/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
      pose: {
        header: {
          stamp: {sec: 0, nanosec: 0},
          frame_id: 'map'
        },
        pose: {
          position: {x: -1.284374475479126,y: 0.1812548041343689,z: 0.0},
          orientation: {x: 0.0,y: 0.0,z: 0.9999999999983182,w: 1.833990146254102e-06}
        }
      }
    }\"
"