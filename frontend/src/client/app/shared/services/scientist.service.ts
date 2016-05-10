// import {Injectable} from 'angular2/core';
import {Scientist} from './scientist';
import {SCIENTISTS} from './mock-scientists';

// @Injectable()
export class ScientistService {
  get() {
    return new Promise<Scientist[]>(resolve =>
      setTimeout(()=>resolve(SCIENTISTS), 500)
    );
  }

  // add(value: string): void {
  //   this.names.push(value);
  // }
}
