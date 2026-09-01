#!/usr/bin/env bash

docker exec multi_turtlebot4_simulation_c bash -c "source /opt/ros/jazzy/setup.bash && ros2 action send_goal robot0/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
      pose: {
        header: {
          stamp: {sec: 0, nanosec: 0},
          frame_id: 'map'
        },
        pose: {
          position: {x: -0.8303335905075073, y: -0.004104167688637972, z: 0.0},
          orientation: {x: 0.0, y: 0.0, z: -0.9999859542559891, w: 0.005300121766432868}
        }
      }
    }\"
"

