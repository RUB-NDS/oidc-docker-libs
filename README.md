# oidc-lab

![Lab Overview](docs/images/lab.svg)

## Minimum system requirements

- 4 CPU cores
- 8 GB RAM
- 24 GB of free space

## Build & Run

```
docker-compose build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN}
docker-compose up
```

## Use proxy

- Configure Browser to use Proxy -> http://localhost:8080
- (optional) Get generated CA oidc-ca.crt from docker volume certs (/var/lib/docker/volumes/oidc-docker-libs_certs/_data/oidc-ca.crt)
    and add it to your browser trust store to avoid self signed ca warning
- Sites could be reached without further host file manipulation e.g. https://openid.professos

## mitmproxy

Mitmproxy is configured to run in regular mode.
Web interface could be found at http://localhost:8081

## The Lab

https://lab

### Professos
 
https://openid.professos/

### IdP

#### MITREid Server
https://mitreid-server/oidc-server/

#### Keycloak

Configuration (Reset after LAB restart):
- https://keycloak:8443/auth/
- User: admin
- Password: 4dm1n

API:
- https://keycloak/auth/realms/master/
- https://keycloak/auth/realms/master/.well-known/openid-configuration

#### Gravitee

Configuration:
- https://gravitee/am/ui/dashboard
- User: admin
- Password: adminadmin

API:
- https://gravitee/am/profnet/oidc/
- https://gravitee/am/profnet/oidc/.well-known/openid-configuration

#### Identity Server4

- https://identity-server4/Account/Login
- https://identity-server4/.well-known/openid-configuration
