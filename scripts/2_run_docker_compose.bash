#!/usr/bin/env bash

xhost +local:docker

docker compose -f docker/docker-compose.yml up -d --force-recreate
