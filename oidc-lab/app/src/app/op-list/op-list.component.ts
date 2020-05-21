import { Component, OnInit } from '@angular/core';

interface OpList {
  id: number;
  name: string;
  url: string;
  cfgurl: string;
}

export const OPLIST: OpList[] = [
  { id: 1, name: 'Gravitee', url: 'https://gravitee/am/ui/', cfgurl:'https://gravitee/am/profnet/oidc/.well-known/openid-configuration' },
  { id: 2, name: 'IdentityServer 4', url: 'https://identity-server4/Account/', cfgurl:'https://identity-server4/.well-known/openid-configuration' },
  { id: 3, name: 'Keycloak', url: 'https://keycloak', cfgurl:'https://keycloak/auth/realms/master/.well-known/openid-configuration' },
  { id: 4, name: 'MITREid', url: 'https://mitreid-server/oidc-server/', cfgurl:'https://mitreid-server/oidc-server/.well-known/openid-configuration' },
  { id: 5, name: 'Node OIDC Provider', url: 'https://node-oidc-provider', cfgurl:'https://node-oidc-provider/.well-known/openid-configuration' },
  { id: 6, name: 'PHP OIDC OP', url: 'https://php-oidc-op', cfgurl:'https://php-oidc-op/.well-known/openid-configuration' },
];

@Component({
  selector: 'app-op-list',
  templateUrl: './op-list.component.html',
  styleUrls: ['./op-list.component.scss']
})
export class OpListComponent implements OnInit {
  oplist = OPLIST;

  constructor() { }

  ngOnInit(): void {
  }
}

