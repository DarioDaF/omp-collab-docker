Using https://github.com/router-for-me/CLIProxyAPI to store credentials etc... in a pod and
share it unauthed to omp

Using officail omp collab with self hosted "development" relay

Having both omp web ui and relay served under same http server

omp running on it's own pod, with configured target llm logins to the proxy; the net connection to the relay on the collab pod

Check if it's possible to run code omp web ui pod into another pod (avoid ssh if possible?) to collect and start collab session in the future

Provide external https acced through VPN like (e.g. tailscale, but serve only, no funnel because it has no auth protection!!!)

@ISSUES: omp collab does not allow any command to alter session (swap model and thinking levels, any slash commands, etc...)
