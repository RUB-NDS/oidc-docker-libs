import { Component, OnInit } from '@angular/core';

interface RpList {
  id: number;
  name: string;
  url: string;
}

export const RPLIST: RpList[] = [
  { id: 1, name: 'Angular auth oidc', url: 'https://angular-auth-oidc-client' },
  { id: 2, name: 'Angular oauth2 oidc', url: 'https://angular-oauth2-oidc-client' },
  { id: 3, name: 'MITREid client', url: 'https://mitreid-client/simple-web-app/'},
  { id: 4, name: 'PHP oidc', url: 'https://php-oidc-rp' },
  { id: 5, name: 'PyOIDC', url: 'https://pyoidc-rp' },
  { id: 6, name: 'Py oidcrp', url: 'https://py-oidcrp' },
  { id: 7, name: 'Mod auth openidc', url: 'https://mod-auth-openidc' },
  { id: 8, name: 'Node openid', url: 'https://express-openid-client' },
];


@Component({
  selector: 'app-rp-list',
  templateUrl: './rp-list.component.html',
  styleUrls: ['./rp-list.component.scss']
})
export class RpListComponent implements OnInit {
  rplist = RPLIST;

  constructor() { }

  ngOnInit(): void {
  }

}
