FROM oven/bun:1-alpine AS build
ARG OMP_REF=main
WORKDIR /repo

#RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
RUN apk add --no-cache git ca-certificates
#RUN git clone https://github.com/can1357/oh-my-pi.git . && git checkout "$OMP_REF"
RUN git init . \
    && git remote add origin https://github.com/can1357/oh-my-pi.git \
    && git fetch --depth 1 origin "$OMP_REF" \
    && git checkout --detach FETCH_HEAD
RUN bun install

# Build the frontend static files
RUN cd packages/collab-web && bun run build
# Build a standalone executable for the relay
RUN bun build --compile --minify --outfile=/srv/relay \
    packages/collab-web/scripts/local-relay.ts

FROM caddy:2-alpine AS web

# Needed for the relay
RUN apk add --no-cache libstdc++

COPY --from=build /repo/packages/collab-web/dist/ /srv/static
COPY --from=build /srv/relay /srv/relay
COPY Caddyfile /etc/caddy/Caddyfile

COPY --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
