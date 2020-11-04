import { Component } from '@angular/core';
import { Config, Menu } from './accordion/types';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  // signle open mode
  options: Config = { multi: false };
  // tslint:disable-next-line: ban-types
  title: String = '';
  private _jsonURL = '../assets/Menus.json';
  menus: Menu[];
  constructor(private http: HttpClient) {
    this.getJSON().subscribe(data => {
      console.log(data);
      this.menus = data.menus;
    })
     
  }
  public getJSON(): Observable<any> {
    return this.http.get(this._jsonURL);
  }
  ngOnInit() {
  }
}

