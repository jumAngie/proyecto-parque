import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BoxedComponent } from './boxed.component';

describe('BoxedComponent', () => {
  let component: BoxedComponent;
  let fixture: ComponentFixture<BoxedComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [BoxedComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BoxedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
