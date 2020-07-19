import { AuthConfig } from 'angular-oauth2-oidc';

export const authCodeFlowConfig: AuthConfig = {
    issuer: 'https://attack-idp.professos/angular-oauth2-oidc',
    redirectUri: window.location.origin + '/index.html',
    clientId: 'angular-oauth2-oidc-client',
    responseType: 'code',
    scope: 'openid profile email',
    showDebugInformation: true,
    timeoutFactor: 0.01
};
