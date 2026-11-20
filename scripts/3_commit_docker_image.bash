#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="${CONTAINER_NAME:-ngp_build_jazzy_c}"

# Check if the container exists
if ! docker ps -a --format '{{.Names}}' 2>/dev/null | grep -Eq "^${CONTAINER_NAME}\$"; then
    echo "Error: Container '$CONTAINER_NAME' does not exist." >&2
    exit 1
fi

if [ -n "${1:-}" ]; then
    IMAGE_NAME="$1"
    if [[ "$IMAGE_NAME" != ngp_* ]]; then
        IMAGE_NAME="ngp_${IMAGE_NAME}"
    fi
else
    images=()
    while IFS= read -r line; do
        [ -n "$line" ] && images+=("$line")
    done < <(docker images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep 'ngp_' | grep -v '<none>' | sed 's|^localhost/||' | awk '!seen[$0]++' || true)

    if [ "${#images[@]}" -eq 0 ]; then
        echo "No docker images with 'ngp_' found. Please provide a custom label."
        read -r -p "Enter custom docker image label name: " custom_input
        if [ -z "$custom_input" ]; then
            echo "Error: Image label name cannot be empty." >&2
            exit 1
        fi
        if [[ "$custom_input" != ngp_* ]]; then
            IMAGE_NAME="ngp_${custom_input}"
        else
            IMAGE_NAME="${custom_input}"
        fi
    else
        for i in "${!images[@]}"; do
            echo "$((i + 1)) - ${images[i]}"
        done
        echo "0 - Custom image label name"

        read -r -p "Enter selection [0-${#images[@]}]: " choice

        if [ "$choice" = "0" ]; then
            read -r -p "Enter custom docker image label name: " custom_input
            if [ -z "$custom_input" ]; then
                echo "Error: Image label name cannot be empty." >&2
                exit 1
            fi
            if [[ "$custom_input" != ngp_* ]]; then
                IMAGE_NAME="ngp_${custom_input}"
            else
                IMAGE_NAME="${custom_input}"
            fi
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#images[@]}" ]; then
            IMAGE_NAME="${images[$((choice - 1))]}"
        else
            echo "Error: Invalid selection '$choice'. Please enter an integer between 0 and ${#images[@]}." >&2
            exit 1
        fi
    fi
fi

echo "Committing '$CONTAINER_NAME' to '$IMAGE_NAME'..."
docker commit "$CONTAINER_NAME" "$IMAGE_NAME"
