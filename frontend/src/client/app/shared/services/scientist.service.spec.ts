import {ScientistService} from './scientist.service';

export function main() {
  describe('Scientist Service', () => {
    let scientistService:ScientistService;

    beforeEach(() => {
      scientistService = new ScientistService;
    });

    it('should return the list of names', () => {
      // let names = scientistService.get();
      // expect(names).toEqual(jasmine.any(Promise));
    });
  });
}
