import { AuthConfig } from 'angular-oauth2-oidc';

export const authCodeFlowConfig: AuthConfig = {
    issuer: 'https://keycloak/auth/realms/master',
    redirectUri: window.location.origin + '/index.html',
    clientId: 'angular-oauth2-oidc-client',
    responseType: 'id_token token',
    scope: 'openid profile email',
    showDebugInformation: true,
    timeoutFactor: 0.01
};
