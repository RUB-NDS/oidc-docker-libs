# RP

## angular-auth-oidc

* https://angular-auth-oidc-client
* Professos static endpoint Test-ID: angular-auth-oidc

Issuer Discovery and Dynamic Client Registration is not supported.
Via docker environment variable ISSUER the attack-idp.professos is registered.

### Configuration
```
angular-auth-oidc-sample-client/config/auth.clientConfiguration.json
```


## angular-oauth2-oidc-client

* https://angular-oauth2-oidc-client
* Professos static endpoint Test-ID: angular-oauth2-oidc

Issuer Discovery and Dynamic Client Registration is not supported.
The attack-idp.professos is registered. 
Professos must expose the Endpoint before this web app is loaded in the browser.

### Configuration
```
angular-oauth2-oidc-client/config/auth.config.ts
```


## node openid (express-openid-client)

Issuer Discovery and Dynamic Client Registration is not supported.
Two app instances are provided, one registered to keycload and one to attacker-idp.professos.

* Keycloak: https://express-openid-client
* Attacker Professos: https://express-openid-client-prof
* Professos static endpoint Test-ID: node-openid

### Configuration
```
express-openid-client/config/env
express-openid-client/config/env.prof
```

### Known Limitations

Node does not respect HTTP_PROXY settings. 
Therefore, Mitmproxy cannot be used and container is directly connected to the OPs.


## mitreid-client

* https://mitreid-client/simple-web-app/

This client supports Issuer Discovery and Dynamic Client Registration.

### Known Limitations

* php-oidc-op returns invalid scope
* keycloak returns invalid scope and must be configured
* gravitee could not parse jwk token


## mod-auth-openidc

* https://mod-auth-openidc/
* Professos static endpoint Test-ID: modauthopenidc

Issuer Discovery is not supported. 

### Configuration
Discovery Metadata must be added to this folder to allow Dynamic Client Registration for these Endpoints.
```
mod-auth-openidc/metadata/
```

### Known Limitations

* Keycloak: Unrecognized field "frontchannel_logout_uri" (class org.keycloak.representations.oidc.OIDCClientRepresentation), not marked as ignorable


## php-oidc-rp

* https://php-oidc-rp

This client supports Issuer Discovery and Dynamic Client Registration.

### Known Limitations

With Keycloak and default settings a metadata error will be raised


## py-oidcrp

* https://py-oidcrp
* Professos static endpoint Test-ID: py-oidcrp

Issuer Discovery is not supported.
Client is configured for professos, keycloak, node-oidc-provider and identify-server4

### Configuration

```
py-oidcrp/config/conf.yaml
```

### Known Limitations

* only code authorization works
    * implicit/hybrid callback /ihf_cb does not work (python error)
    * implicit url hash fragment is not handled


## pyoidc-rp

* https://py-oidcrp
* Professos static endpoint Test-ID: pyoidc-rp

Issuer Discovery is not supported.
Client is configured for Professos and Keycloak.

### Configuration

```
pyoidc-rp/config/provider.json
```

### Known Limitations

* Dynamic Registration works with a quick fix. Redirect uri from json is used without any sanity check.
    * Client registers always with Authorization Code Flow
    * Login could be done with Implicit Flow, but client must be reconfigured on op site to allow Implicit Flow
    * Hybrid mode does not work
    * /.well-known/openid-configuration is only retrieved on startup
* ISSUER must be online before app starts, else it crashes during app initialization. Container must be restarted afterwards!


