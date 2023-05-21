import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ButtonspageComponent } from './buttonspage.component';

describe('ButtonspageComponent', () => {
  let component: ButtonspageComponent;
  let fixture: ComponentFixture<ButtonspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ButtonspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ButtonspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
