#!/usr/bin/env bash

BUILDKIT_PROGRESS=plain docker compose -f docker/docker-compose.yml build
