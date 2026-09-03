#!/usr/bin/env bash

docker build --progress=plain --load -t ros2_rust_base:jazzy -f docker/Dockerfile.base .
