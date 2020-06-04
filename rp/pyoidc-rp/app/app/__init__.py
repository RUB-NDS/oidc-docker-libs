import os

from flask import Flask, request, current_app, json
from flask_bootstrap import Bootstrap
from config import Config
from flask_pyoidc import OIDCAuthentication
from flask_pyoidc.provider_configuration import ProviderConfiguration, ClientMetadata


def parse_oidc_config(logout_uri):
    oidc_config=dict()
    with open('provider.json') as provider_file:
        provider_data = json.load(provider_file)
        for provider in provider_data:
            config = ProviderConfiguration(issuer=provider_data[provider]['issuer'],
                                           client_metadata=ClientMetadata(provider_data[provider]['client_id'],
                                                                          provider_data[provider]['client_secret'],
                                                                          post_logout_redirect_uris=[logout_uri + '/logout']))
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

    bootstrap.init_app(app)
    auth.init_app(app)

    # init blueprints
    from app.errors import bp as errors_bp
    app.register_blueprint(errors_bp)

    from app.main import bp as main_bp
    app.register_blueprint(main_bp)

    return app
