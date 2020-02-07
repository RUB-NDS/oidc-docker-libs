# oidc-lab

## Build & Run

```
docker-compose build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN}
docker-compose up
```

## Use proxy

- Configure Browser to use Proxy -> http://localhost:8080
- (optional) Get generated CA oidc-ca.crt from docker volume certs (/var/lib/docker/volumes/oidc-lab_certs/_data/oidc-ca.crt)
    and add it to your browser trust store to avoid self signed ca warning
- Sites could be reached without further host file manipulation e.g. https://openid.professos

## mitmproxy

Mitmproxy is configured to run in regular mode.
Web interface could be found at http://localhost:8081

