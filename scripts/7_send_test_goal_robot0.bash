#!/usr/bin/env bash

docker exec -it next_gen_prototype_c bash -c "source /nav2_traffic_ws/install/setup.bash && \
      ros2 action send_goal robot0/navigate_to_pose nav2_msgs/action/NavigateToPose \"{
    pose: {
      header: {
        stamp: {sec: 0, nanosec: 0},
        frame_id: 'map'
      },
      pose: {
        position: {x: 5.0, y: 5.0, z: 0.0},
        orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
      }
    }
  }\"
"