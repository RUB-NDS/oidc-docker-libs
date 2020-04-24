import { HttpClientModule } from '@angular/common/http';
import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule } from '@angular/router';
import { AuthModule, ConfigResult, OidcConfigService, OidcSecurityService, OpenIdConfiguration } from 'angular-auth-oidc-client';
import { AppComponent } from './app.component';

const oidc_configuration = 'assets/auth.clientConfiguration.json';
// if your config is on server side
// const oidc_configuration = ${window.location.origin}/api/ClientAppSettings

export function loadConfig(oidcConfigService: OidcConfigService) {
  return () => oidcConfigService.load(oidc_configuration);
}

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    HttpClientModule,
    RouterModule.forRoot([
      { path: '', component: AppComponent },
      { path: 'home', component: AppComponent },
      { path: 'forbidden', component: AppComponent },
      { path: 'unauthorized', component: AppComponent },
    ]),
    AuthModule.forRoot(),
  ],
  providers: [
    OidcConfigService,
    {
      provide: APP_INITIALIZER,
      useFactory: loadConfig,
      deps: [OidcConfigService],
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {
  constructor(private oidcSecurityService: OidcSecurityService, private oidcConfigService: OidcConfigService) {
    this.oidcConfigService.onConfigurationLoaded.subscribe((configResult: ConfigResult) => {

      // Use the configResult to set the configurations

      const config: OpenIdConfiguration = {
        stsServer: configResult.customConfig.stsServer,
        redirect_url: configResult.customConfig.redirect_url,
        client_id: configResult.customConfig.client_id,
        scope: configResult.customConfig.scope,
        response_type: configResult.customConfig.response_type,
        silent_renew: configResult.customConfig.silent_renew,
        silent_renew_url: configResult.customConfig.silent_renew_url,
        log_console_debug_active: true,
        // all other properties you want to set
      };

      this.oidcSecurityService.setupModule(config, configResult.authWellknownEndpoints);
    });
  }
}
