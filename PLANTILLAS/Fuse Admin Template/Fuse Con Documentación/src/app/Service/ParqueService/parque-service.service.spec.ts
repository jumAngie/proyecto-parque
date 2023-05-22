import { TestBed } from '@angular/core/testing';

import { ParqueServiceService } from './parque-service.service';

describe('ParqueServiceService', () => {
  let service: ParqueServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ParqueServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
