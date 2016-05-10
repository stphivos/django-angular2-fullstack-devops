import {Component, OnInit} from 'angular2/core';
import {CORE_DIRECTIVES, FORM_DIRECTIVES} from 'angular2/common';

import {ScientistService} from '../../shared/index';
import {Scientist} from '../../shared/services/scientist';

@Component({
  selector: 'sd-home',
  templateUrl: 'app/+home/components/home.component.html',
  styleUrls: ['app/+home/components/home.component.css'],
  directives: [FORM_DIRECTIVES, CORE_DIRECTIVES]
})

export class HomeComponent implements OnInit {
  // newName:string;
  scientists:Scientist[] = [];

  constructor(public scientistService:ScientistService) {
  }

  ngOnInit() {
    this.scientistService.get().then(scientists => this.scientists = scientists);
  }

  // /*
  //  * @param newname  any text as input.
  //  * @returns return false to prevent default form submit behavior to refresh the page.
  //  */
  // addName(): boolean {
  //   this.nameListService.add(this.newName);
  //   this.newName = '';
  //   return false;
  // }
}
