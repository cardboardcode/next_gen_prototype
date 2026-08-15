#!/usr/bin/env bash

docker build --progress=plain --load -t next_gen_prototype:jazzy_nav2 -f docker/Dockerfile.nav2 .
