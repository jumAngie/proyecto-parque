import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProgresspageComponent } from './progresspage.component';

describe('ProgresspageComponent', () => {
  let component: ProgresspageComponent;
  let fixture: ComponentFixture<ProgresspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ProgresspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgresspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
