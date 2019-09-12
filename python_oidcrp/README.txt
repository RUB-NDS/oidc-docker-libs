Could not make the example from https://github.com/openid/JWTConnect-Python-OidcRP work... :(

Main problem seems to be that the example RP oes not follow redirects in webfinger responses. That is, if a request to 
  https://idp.honest-sso.de/.well-known/webfinger?rel=OIDC&href=https://idp.honest-sso.de/dispatch/TESTID
returns a response with status code 302 and location header
  Location: https://idp.honest-sso.de/dispatch/TESTID/.well-known/webfinger
the redirect is not followed.

Could not find where exactly the request is issued and therefore oculd not patch the python RP. I tried to enable redirects in the underlying requests library (see sed command in Dockerfile) but to no avail.
If we changed PrOfESSOS to directly return the correct webfinger response, the issuer would not match the requested URL and (sensible) RPs would fail to process the response. 

Further Note: This Python RP requires https for IdP locations, even though certificate verification can be disabled, TLS is a hard requirement. So, to further debug the RP, use the PrOfESSOS branch nginx-proxy, which includes a nginx reverse proxy that terminates TLs using a self issued TLS cert.  
To disable the permissions check for the .professos file at the server root set the environment variable OPIV_TARGET_GRANT_NOT_NEEDED=true
