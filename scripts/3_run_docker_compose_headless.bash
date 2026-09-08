#!/usr/bin/env bash

docker compose -f docker/docker-compose.yml -f docker/docker-compose.headless.override.yml up -d --force-recreate
