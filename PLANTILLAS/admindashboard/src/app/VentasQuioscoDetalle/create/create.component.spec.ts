import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VentasCrearComponent } from './create.component';

describe('VentasCrearComponent', () => {
  let component: VentasCrearComponent;
  let fixture: ComponentFixture<VentasCrearComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [VentasCrearComponent]
    });
    fixture = TestBed.createComponent(VentasCrearComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
