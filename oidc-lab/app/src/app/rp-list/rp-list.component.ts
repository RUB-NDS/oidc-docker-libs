import { Component, OnInit } from '@angular/core';

interface RpList {
  id: number;
  name: string;
  url: string;
}

export const RPLIST: RpList[] = [
  { id: 1, name: 'Angular auth oidc', url: 'https://angular-auth-oidc-client' },
  { id: 2, name: 'MITREid Client', url: 'https://mitreid-client/simple-web-app/'},
  { id: 3, name: 'PHP OIDC RP', url: 'https://php-oidc-rp' },
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
