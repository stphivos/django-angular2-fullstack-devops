import {Component} from 'angular2/core';
import {ROUTER_DIRECTIVES} from 'angular2/router';

@Component({
  selector: 'sd-toolbar',
  templateUrl: 'app/components/toolbar.component.html',
  styleUrls: ['app/components/toolbar.component.css'],
  directives: [ROUTER_DIRECTIVES]
})

export class ToolbarComponent {
}
