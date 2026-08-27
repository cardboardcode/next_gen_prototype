#!/usr/bin/env bash

docker build --progress=plain --load -t ros2_rust_nav2_tb4_sim:jazzy -f docker/Dockerfile.base .
