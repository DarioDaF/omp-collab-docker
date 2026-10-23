#!/bin/sh
set -eu

# Forward localhost:8080 -> web-proxy:8080
socat TCP-LISTEN:8080,bind=127.0.0.1,reuseaddr,fork \
      TCP:web-proxy.internal:8080 &
SOCAT_PID=$!

trap 'kill "$SOCAT_PID" 2>/dev/null || true' EXIT TERM INT

# Execute the container's original command
exec "$@"
