# OP

## Gravitee 
* Professos fails because of missing subject_types_supported
``` 
subject_types_supported was removed with 3.0.0
https://github.com/gravitee-io/issues/issues/3614
```

## Keycloak

* No issues found

## mitreid-server

* No issues found

## php-oidc-op

* No issues known

## node-oidc-provider

* login could be done with any user/password combination and does provide static configured Account John

## identity-server4

* No Dynamic Registration --> Professos?!


RP
========================================================================================================================

## mod-auth-openidc
* Dynamic registration works
* professos could be a problem, well-known metainfos must be downloaded
* gravitee and php-oidc-op could be used 
* keycloak: Unrecognized field "frontchannel_logout_uri" (class org.keycloak.representations.oidc.OIDCClientRepresentation), not marked as ignorable

## mitreid-client

* Dynamic registration works
* php-oidc-op returns invalid scope
* keycloak returns invalid scope and must be configured
* gravitee could not parse jwk token

## php-oidc-rp

* Dynamic registration works with php-oidc-op, with keycloak and default connection settings a metadata error will be raised
* implicit/hybrid should work

## py-oidcrp

* Dynamic registration works with keycloak
* Professos issuer must contain OPIV TEST ID: "profnet"
* auth with response_types "code" works, other response_types "code id_token token" produce errors but tokens retrieved in URL
* implicit/hybrid callback /ihf_cb does not work (python error)

## pyoidc-rp

* Dynamic registration does not work
```
pyoidc-rp_1                   |     self._client_metadata = ClientMetadata(redirect_uris=redirect_uris, **resp.json())
pyoidc-rp_1                   | TypeError: ABCMeta object got multiple values for keyword argument 'redirect_uris'
```
* Static configuration could be done
* ISSUER must be online before app starts, else it crashes during app initialization. Container must be restarted afterwards!!!!!

## node openid (express-openid-client)

* Dynamic registration seems to be not supported with this client, nothing found in API documentation
* node does not respect HTTP_PROXY settings -> mitmproxy could not be used
* only one provider could be configured. On site load provider should be up, else it runs into timeout after 2400ms. Site must be reloaded afterwards


## angular-oauth2-oidc-client

* No dynamic registration
* ISSUER must run, before site is displayed correctly

## angular-auth-oidc

* No dynamic registration