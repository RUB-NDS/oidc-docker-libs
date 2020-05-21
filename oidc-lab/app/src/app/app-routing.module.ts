import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {OpListComponent} from "./op-list/op-list.component";
import {RpListComponent} from "./rp-list/rp-list.component";

const routes: Routes = [
  { path: '', redirectTo: '/op', pathMatch: 'full' },
  { path: 'op', component: OpListComponent },
  { path: 'rp', component: RpListComponent }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
