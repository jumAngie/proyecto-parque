import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetallesempleadosComponent } from './detallesempleados.component';

describe('DetallesempleadosComponent', () => {
  let component: DetallesempleadosComponent;
  let fixture: ComponentFixture<DetallesempleadosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DetallesempleadosComponent]
    });
    fixture = TestBed.createComponent(DetallesempleadosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
