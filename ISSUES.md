
## mod-auth-openidc
* No discovery support (test_id=modauthopenidc)
    * OPIV.createTestPlan("RP-TestPlan","test_id=modauthopenidc")
* Dynamic registration works
* gravitee and php-oidc-op could be used 
* keycloak: Unrecognized field "frontchannel_logout_uri" (class org.keycloak.representations.oidc.OIDCClientRepresentation), not marked as ignorable

## mitreid-client

* Discovery and dynamic registration works
* php-oidc-op returns invalid scope
* keycloak returns invalid scope and must be configured
* gravitee could not parse jwk token

## php-oidc-rp

* Discovery and dynamic registration works with php-oidc-op
    * keycloak and default connection settings a metadata error will be raised
* implicit/hybrid should work

## py-oidcrp

* No discovery support (test_id=py-oidcrp)
    * OPIV.createTestPlan("RP-TestPlan","test_id=py-oidcrp")
* Dynamic registration works with keycloak (/.well-known/openid-configuration loaded on each login attempt)
* only code authorization works
    * implicit/hybrid callback /ihf_cb does not work (python error)
    * implicit url hash fragment is not handled

## pyoidc-rp

* No discovery support (test_id=pyoidc-rp)
    * OPIV.createTestPlan("RP-TestPlan","test_id=pyoidc-rp")
* Dynamic registration does work with quick fix. Redirect uri from json is used without any sanity check.
    * Registration always done with Authorization Code Flow
    * Login could be done with Implicit Flow, but client must be reconfigured on op site to allow implicit flow
    * Hybrid mode does not work
    * /.well-known/openid-configuration is only retrieved on startup 
* ISSUER must be online before app starts, else it crashes during app initialization. Container must be restarted afterwards!!!!!

## node openid (express-openid-client)

* Discovery and dynamic registration is not supported -> attack-idp.professos registered
* node does not respect HTTP_PROXY settings -> mitmproxy could not be used
* Only one provider could be configured.

## angular-oauth2-oidc-client

* No discovery and dynamic registration is not supported -> attack-idp.professos registered
* ISSUER must run before page load

## angular-auth-oidc

* No discovery and dynamic registration -> attack-idp.professos registered
* jwks Token needs optional field "kid" which is not provided by professos
