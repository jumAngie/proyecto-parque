import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ExecutiveBuilderComponent } from './executive-builder.component';

describe('ExecutiveBuilderComponent', () => {
  let component: ExecutiveBuilderComponent;
  let fixture: ComponentFixture<ExecutiveBuilderComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ExecutiveBuilderComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExecutiveBuilderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
