#!/usr/bin/env bash

echo "Follow Steps 2, 4, 5 in root README.md."
echo "Execute: ros2 launch rmf_path_server_demo demo.launch.py"

docker run -it --rm \
    --name next_gen_prototype \
    -p 8080:8080 \
next_gen:latest bash -c "cd / && bash"
