import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetalleQuioscoComponent } from './detalle.component';

describe('DetalleQuioscoComponent', () => {
  let component: DetalleQuioscoComponent;
  let fixture: ComponentFixture<DetalleQuioscoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DetalleQuioscoComponent]
    });
    fixture = TestBed.createComponent(DetalleQuioscoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
