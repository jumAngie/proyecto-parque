import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VentasListComponent } from './list.component';

describe('VentasListComponent', () => {
  let component: VentasListComponent;
  let fixture: ComponentFixture<VentasListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VentasListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VentasListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
