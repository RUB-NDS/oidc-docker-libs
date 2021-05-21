# OP

## Gravitee

* https://gravitee/am/ui/
* Endpoint: https://gravitee/am/profnet/oidc/
* OpenID Configuration: https://gravitee/am/profnet/oidc/.well-known/openid-configuration

### User default credentials

| username | password |
|----------|----------|
| admin | adminadmin |
| alice | W0nderland |
| bob | Und3rland |

Credentials and other settings are stored in mongo db database dump.
Changes will be restored automatically on each lab restart (docker-compose down && docker-compose up)!
```
gravitee/dump.gz
```

## Identity Server4

* https://identity-server4/
* Endpoint: https://identity-server4/
* OpenID Configuration: https://identity-server4/.well-known/openid-configuration

### User default credentials

| username | password |
|----------|----------|
| alice | alice |
| bob | bob |

### Client configuration
IdentifyServer4 does not support Dynamic Client Registration.

To add more RP clients use:
```
identity-server4/config/Config.cs
```


## Keycloak

* https://keycloak/auth/
* Endpoint: https://keycloak/auth/realms/master/
* OpenID Configuration: https://keycloak/auth/realms/master/.well-known/openid-configuration


### User default credentials

| username | password |
|----------|----------|
| admin | 4dm1n |
| user1 | user1pass |
| user2 | user2pass |

Credentials and other settings are stored in a db database dump.
Changes will be restored automatically on each lab restart (docker-compose down && docker-compose up)!
```
keycloak/config/keycloak.sql
```


## MITREid Server

* https://mitreid-server/oidc-server/
* Endpoint: https://mitreid-server/oidc-server/
* OpenID Configuration: https://mitreid-server/oidc-server/.well-known/openid-configuration

### User default credentials

| username | password |
|----------|----------|
| admin | password |
| user1 | user1pass |
| user2 | user2pass |

These default configurations can be changed in file:
```
mitreid-server/config/WEB-INF/classes/db/hsql/users.sql
```


## node-oidc-provider

* https://node-oidc-provider
* Endpoint: https://node-oidc-provider
* OpenID Configuration: https://node-oidc-provider/.well-known/openid-configuration

### User default credentials

| username | password |
|----------|----------|
| user1 | user1pass |
| user2 | user2pass |

Login can be archived with any user/password combination and does provide static configured Account John


## php-oidc-op

* https://php-oidc-op
* Endpoint: https://php-oidc-op
* OpenID Configuration: https://php-oidc-op/.well-known/openid-configuration

### User default credentials

| username | password |
|----------|----------|
| alice | wonderland |
| bob | underland |

These default configurations can be changed in file:
```
php-oidc-op/dump/create_db.sql
```
