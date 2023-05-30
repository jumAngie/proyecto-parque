import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AtraccionesDetailComponent } from './detail.component';

describe('AtraccionesDetailComponent', () => {
  let component: AtraccionesDetailComponent;
  let fixture: ComponentFixture<AtraccionesDetailComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AtraccionesDetailComponent]
    });
    fixture = TestBed.createComponent(AtraccionesDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
