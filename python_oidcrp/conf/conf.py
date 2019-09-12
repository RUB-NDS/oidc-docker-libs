# BASE = "https://lingon.ladok.umu.se"

PORT = 8089

# If PORT and not default port
#BASEURL = "https://localhost:{}".format(PORT)
# else
# BASEURL = "https://localhost"
BASEURL = "http://honest-sp.com"

# If BASE is https these has to be specified
SERVER_CERT = "certs/cert.pem"
SERVER_KEY = "certs/key.pem"
CA_BUNDLE = None

VERIFY_SSL = False

KEYDEFS = [
    {"type": "RSA", "key": '', "use": ["sig"]},
    {"type": "EC", "crv": "P-256", "use": ["sig"]}
]

PRIVATE_JWKS_PATH = "jwks_dir/jwks.json"
PUBLIC_JWKS_PATH = 'static/jwks.json'
# information used when registering the client, this may be the same for all OPs

SERVICES = ['ProviderInfoDiscovery', 'Registration', 'Authorization',
            'AccessToken', 'RefreshAccessToken', 'UserInfo']

CLIENT_PREFS = {
    "application_type": "web",
    "application_name": "rphandler",
    "contacts": ["ops@example.com"],
    "response_types": ["code", "id_token", "id_token token", "code id_token",
                       "code id_token token", "code token"],
    "scope": ["openid", "profile", "email", "address", "phone"],
    "token_endpoint_auth_method": "client_secret_basic",
    'services': SERVICES
}

# The keys in this dictionary are the OPs short user friendly name
# not the issuer (iss) name.

CLIENTS = {
    # The ones that support webfinger, OP discovery and client registration
    # This is the default, any client that is not listed here is expected to
    # support dynamic discovery and registration.
    "": {
        "client_preferences": CLIENT_PREFS,
        "redirect_uris": None,
        "services": {
            'WebFinger': {},
            'ProviderInfoDiscovery': {},
            'Registration': {},
            'Authorization': {},
            'AccessToken': {},
            'RefreshAccessToken': {},
            'UserInfo': {}
        }
    },
   

}

# Whether an attempt to fetch the userinfo should be made
USERINFO = True
