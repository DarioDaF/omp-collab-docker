#!/bin/sh
set -eu

# Move to the script's directory
cd "$(dirname "$(realpath "$0")")"

# Create initial folders in data
if [ ! -d "./data/agent" ]; then
    mkdir -p "./data/agent"
    cp -r "./omp-agent/agent-seed/." "./data/agent/"
fi
mkdir -p "./data/llm-proxy-auths"

# Commands with possibly arguments with spaces do not work well with variables, so use a POSIX function
if command -v podman >/dev/null 2>&1; then
    container_runtime() {
        podman "$@"
    }
elif command -v docker >/dev/null 2>&1; then
    container_runtime() {
        docker "$@"
    }
else
    echo "Error: neither Podman nor Docker is installed." >&2
    exit 1
fi

# Start containers using Podman or Docker
container_runtime compose up -d
container_runtime compose exec omp-agent omp
