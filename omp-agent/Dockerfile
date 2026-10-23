FROM oven/bun:1
RUN apt-get update && apt-get install -y --no-install-recommends git openssh-client ca-certificates curl bash socat && rm -rf /var/lib/apt/lists/*
RUN bun install -g @oh-my-pi/pi-coding-agent

COPY --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /workspace

CMD ["sleep", "infinity"]
