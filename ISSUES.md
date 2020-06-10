
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

* Dynamic registration for keycloak works
* auth with response_types "code" works, other response_types "code id_token token" produce errors but tokens retrieved in URL
* implicit/hybrid callback /ihf_cb does not work (python error)
