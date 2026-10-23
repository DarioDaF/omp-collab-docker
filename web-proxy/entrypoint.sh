#!/bin/sh
set -eu

# Start relay in background
/srv/relay &
RELAY_PID=$!

# Start Caddy in background
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
CADDY_PID=$!

# Stop both processes on container shutdown
trap 'kill "$RELAY_PID" "$CADDY_PID" 2>/dev/null || true' TERM INT

# Exit if either process exits
wait -n "$RELAY_PID" "$CADDY_PID"
STATUS=$?

kill "$RELAY_PID" "$CADDY_PID" 2>/dev/null || true
wait 2>/dev/null || true

exit "$STATUS"
