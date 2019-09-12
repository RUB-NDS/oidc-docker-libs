This setup is based upon

https://github.com/rohe/oidctest/tree/master/docker/op

Note: the latest version I was able to setup and get running is tags/v4.5.0. All newer versions throw an
error on startup about missing modules or misconfigured routes, which I was not able to fix.

Unforutnately, even in the older versions for which the example provider can successfully be started, redemption
of issued authentication codes in the token request indeterministically fails with '{error: null}'. Therefore,
using this node-oidc-provider as TestTarget for automated tests is not recommended until a fix for these 
issues is found
