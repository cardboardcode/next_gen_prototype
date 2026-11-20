#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -n "${1:-}" ]; then
    IMAGE_NAME="$1"
    if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1 && [[ "$IMAGE_NAME" != ngp_* ]]; then
        IMAGE_NAME="ngp_${IMAGE_NAME}"
    fi
else
    images=()
    while IFS= read -r line; do
        [ -n "$line" ] && images+=("$line")
    done < <(docker images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep 'ngp_' | grep -v '<none>' | sed 's|^localhost/||' | awk '!seen[$0]++' || true)

    if [ "${#images[@]}" -eq 0 ]; then
        echo "Error: No docker images with 'ngp_' prefix found." >&2
        exit 1
    fi

    if [ "${#images[@]}" -eq 1 ]; then
        IMAGE_NAME="${images[0]}"
        echo "Only one image found, auto-selecting: ${IMAGE_NAME}"
    else
        for i in "${!images[@]}"; do
            echo "$((i + 1)) - ${images[i]}"
        done

        read -r -p "Enter selection [1-${#images[@]}]: " choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#images[@]}" ]; then
            IMAGE_NAME="${images[$((choice - 1))]}"
        else
            echo "Error: Invalid selection '$choice'. Please enter an integer between 1 and ${#images[@]}." >&2
            exit 1
        fi
    fi
fi

if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    echo "Error: Docker image '${IMAGE_NAME}' not found locally." >&2
    exit 1
fi

# Allow Docker containers to access X11
# -----------------------------------------------------------------------------
xhost +local:docker

echo "Running Nav2 integration simulation with image: ${IMAGE_NAME}"
ROS2_IMAGE="$IMAGE_NAME" docker compose -f "${REPO_ROOT}/docker/docker-compose.yml" up -d --no-build --force-recreate
