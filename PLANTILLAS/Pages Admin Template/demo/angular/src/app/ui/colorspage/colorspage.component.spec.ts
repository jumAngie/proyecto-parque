import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ColorspageComponent } from './colorspage.component';

describe('ColorspageComponent', () => {
  let component: ColorspageComponent;
  let fixture: ComponentFixture<ColorspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ColorspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ColorspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
