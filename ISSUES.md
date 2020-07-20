# OP

## Gravitee 
* Professos fails because of missing subject_types_supported
    * workaround added to professos (use public if required subject_types_supported is not defined)
``` 
subject_types_supported was removed with 3.0.0
https://github.com/gravitee-io/issues/issues/3614
```

## Keycloak

* No issues found

## mitreid-server

* No issues found

## php-oidc-op

* No issues found

## node-oidc-provider

* login could be done with any user/password combination and does provide static configured Account John

## identity-server4

* No Dynamic Registration


RP
========================================================================================================================

## mod-auth-openidc
* Dynamic registration works, but no discovery support
* professos must be configured with static test id
    * Only /.well-known/jwks.json will be requested by this service
* gravitee and php-oidc-op could be used 
* keycloak: Unrecognized field "frontchannel_logout_uri" (class org.keycloak.representations.oidc.OIDCClientRepresentation), not marked as ignorable

## mitreid-client

* Dynamic registration works
* php-oidc-op returns invalid scope
* keycloak returns invalid scope and must be configured
* gravitee could not parse jwk token

## php-oidc-rp

* Dynamic registration works with php-oidc-op
    * keycloak and default connection settings a metadata error will be raised
    * professos raise error during learning phase, user-needle not found but should exist in response
* implicit/hybrid should work

## py-oidcrp

* Dynamic registration works with keycloak (/.well-known/openid-configuration loaded on each login attempt)
* Professos issuer must contain OPIV TEST ID: "profnet"
* auth with response_types "code" works, other response_types "code id_token token" produce errors but tokens retrieved in URL
* implicit/hybrid callback /ihf_cb does not work (python error)
* implicit url hash fragment is not handled

## pyoidc-rp

* Dynamic registration does work with quick fix. Redirect uri from json is used without any sanity check.
    * Registration always done with Authorization Code Flow
    * Login could be done with Implicit Flow, but client must be reconfigured on op site to allow implicit flow
    * Hybrid mode does not work
    * /.well-known/openid-configuration is only retrieved on startup 
* Static configuration could be done
* ISSUER must be online before app starts, else it crashes during app initialization. Container must be restarted afterwards!!!!!

## node openid (express-openid-client)

* Discovery and Dynamic registration is not supported
* node does not respect HTTP_PROXY settings -> mitmproxy could not be used
* Only one provider could be configured.

## angular-oauth2-oidc-client

* No dynamic registration (/.well-known/openid-configuration loaded on each login attempt)
* ISSUER must run before page load

## angular-auth-oidc

* No dynamic registration (/.well-known/openid-configuration loaded on each login attempt)
* jwks Token needs optional field "kid" which is not provided by professos
