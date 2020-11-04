import { Component, OnInit, Input } from '@angular/core';
import { Config, Menu } from './types';

@Component({
  // tslint:disable-next-line: component-selector
  selector: 'accordion',
  templateUrl: './accordion.component.html',
  styleUrls: ['./accordion.component.css']
})
export class AccordionComponent implements OnInit {
  @Input() options;
  @Input() menus: Menu[];
  config: Config;

  // tslint:disable-next-line: typedef
  ngOnInit() {
    this.config = this.mergeConfig(this.options);
  }

  // tslint:disable-next-line: typedef
  mergeConfig(options: Config) {
    const config = {
      // selector: '#accordion',
      multi: true
    };

    return { ...config, ...options };
  }

  // tslint:disable-next-line: typedef
  toggle(index: number) {
    if (!this.config.multi) {
      this.menus.filter(
        (menu, i) => i !== index && menu.active
      ).forEach(menu => menu.active = !menu.active);
    }

    this.menus[index].active = !this.menus[index].active;
  }
}
