import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CrearempleadosComponent } from './crearempleados.component';

describe('CrearempleadosComponent', () => {
  let component: CrearempleadosComponent;
  let fixture: ComponentFixture<CrearempleadosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CrearempleadosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CrearempleadosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
