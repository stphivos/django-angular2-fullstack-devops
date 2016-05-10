import {
  TestComponentBuilder,
  describe,
  expect,
  it,
  inject
} from 'angular2/testing';
import {Component} from 'angular2/core';
// import {DOM} from 'angular2/src/platform/dom/dom_adapter';
import {HomeComponent} from './home.component';
import {ScientistService} from '../../shared/index';

export function main() {
  describe('Home component', () => {
    it('should work',
      inject([TestComponentBuilder], (tcb:TestComponentBuilder) => {
        tcb.createAsync(TestComponent)
          .then(rootTC => {
            rootTC.detectChanges();

            let homeInstance = rootTC.debugElement.children[0].componentInstance;
            // let homeDOMEl = rootTC.debugElement.children[0].nativeElement;
            // let scientistLen = function () {
            //   return homeInstance.scientistService.names.length;
            // };

            expect(homeInstance.scientistService).toEqual(jasmine.any(ScientistService));
            // expect(scientistLen()).toEqual(4);
            // expect(DOM.querySelectorAll(homeDOMEl, 'li').length).toEqual(scientistLen());

            // homeInstance.newName = 'Minko';
            // homeInstance.addName();
            //rootTC.detectChanges();

            // expect(scientistLen()).toEqual(5);
            // expect(DOM.querySelectorAll(homeDOMEl, 'li').length).toEqual(scientistLen());
            // expect(DOM.querySelectorAll(homeDOMEl, 'li')[4].textContent).toEqual('Minko');
          });
      }));
  });
}

@Component({
  providers: [ScientistService],
  selector: 'test-cmp',
  template: '<sd-home></sd-home>',
  directives: [HomeComponent]
})

class TestComponent {
}
