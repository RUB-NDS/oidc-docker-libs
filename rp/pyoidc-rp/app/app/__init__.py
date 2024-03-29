import os

from flask import Flask, request, current_app, json
from flask_bootstrap import Bootstrap
from config import Config
from flask_pyoidc import OIDCAuthentication
from flask_pyoidc.provider_configuration import ProviderConfiguration, ClientMetadata, ClientRegistrationInfo


def parse_oidc_config(logout_uri):
    oidc_config=dict()
    with open('provider.json') as provider_file:
        provider_data = json.load(provider_file)
        for provider in provider_data:
            config = ProviderConfiguration(issuer=provider_data[provider]['issuer'],
                                           client_registration_info=ClientRegistrationInfo(client_name='pyoidc-rp',
                                                                                           contacts=['dev@rp.example.com']),
                                           auth_request_params={ "response_type": "id_token token" }
                                           )
            oidc_config.update({provider: config})
    return oidc_config


base_uri = os.environ.get("BASE_URI")
if not base_uri:
    raise ValueError("No BASE_URI environment set for application")
auth = OIDCAuthentication(parse_oidc_config(base_uri))


bootstrap = Bootstrap()


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    app.config['BOOTSTRAP_SERVE_LOCAL'] = True

    bootstrap.init_app(app)
    auth.init_app(app)
    for client in auth.clients:
        print(client)
#        if auth.clients[client].post_logout_redirect_uris is None:
#            auth.clients[client].post_logout_redirect_uris = base_uri + '/logout'
#        print(auth.clients[client].post_logout_redirect_uris[0])

    # init blueprints
    from app.errors import bp as errors_bp
    app.register_blueprint(errors_bp)

    from app.main import bp as main_bp
    app.register_blueprint(main_bp)

    return app


