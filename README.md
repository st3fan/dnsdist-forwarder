# DNSDist Forwarder

A [dnsdist](https://dnsdist.org/) Docker image that listens on plain DNS
(port 53) and forwards every query upstream over an encrypted transport.

It **prefers DNS-over-TLS** to Google and Cloudflare and **falls
back to DNS-over-HTTPS** to the same providers when DoT is unreachable
(e.g. port 853 blocked on the local network). Active health checks detect
the failure within ~1–2 seconds and route around it; recovery is automatic
when DoT becomes reachable again.

Published as `ghcr.io/st3fan/dnsdist-forwarder`.

## Tags

- `develop` — latest build from `main`
- `vX.Y.Z`, `X.Y.Z`, `X.Y`, `X`, `latest` — built when a `v*` git tag is pushed

## Build locally

```sh
docker build -t dnsdist-forwarder .
```

## Run

```sh
docker run -d --name dnsdist-forwarder \
    -p 53:53/udp -p 53:53/tcp \
    ghcr.io/st3fan/dnsdist-forwarder:develop
```

## Upstream resolvers

Same six addresses on both transports, with TLS certificate validation:

- Google: `8.8.8.8`, `8.8.4.4` (`dns.google`)
- Cloudflare: `1.1.1.1`, `1.0.0.1` (`cloudflare-dns.com`)
- Quad9: `9.9.9.10`, `149.112.112.10` (`dns10.quad9.net`)

DoT uses port 853; DoH uses port 443 with the `/dns-query` endpoint.
