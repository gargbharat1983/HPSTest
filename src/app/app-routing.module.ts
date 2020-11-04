import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {CSSComponent} from './css/css.component';
import { HTMLComponent } from './html/html.component';
import { JavascriptComponent } from './javascript/javascript.component';
const routes: Routes = [
  {
    path: '',
    component: CSSComponent,
    pathMatch: 'full'
  },
  {
    path: 'html',
    component: HTMLComponent,
    pathMatch: 'full'
  },
  {
    path: 'javascript',
    component: JavascriptComponent,
    pathMatch: 'full'
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
