from mitmproxy import ctx, http


def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_url == "https://attack-idp.professos/angular-auth-oidc/user-info" and flow.request.method == "OPTIONS":
        ctx.log.info("Intercept angular auth oidc OPTIONS request")
        flow.response = http.HTTPResponse.make(
            200,
            b"",  # (optional) content
            {"Access-Control-Allow-Origin": "https://angular-auth-oidc-client",
             "Access-Control-Allow-Credentials": "true",
             "Access-Control-Allow-Methods": "GET, HEAD, OPTIONS",
             "Access-Control-Allow-Headers": "Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization",
             "X-XSS-Protection": "1; mode=block",
             "Strict-Transport-Security": "max-age=31536000; includeSubDomains"}  # (optional) headers
        )
