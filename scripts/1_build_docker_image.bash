#!/usr/bin/env bash 

docker build --progress=plain --load -f docker/Dockerfile.base -t ngp_build:jazzy .
