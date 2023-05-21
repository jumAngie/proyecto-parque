import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SecondaryHorizontalCasualComponent } from './secondary-horizontal-casual.component';

describe('SecondaryHorizontalCasualComponent', () => {
  let component: SecondaryHorizontalCasualComponent;
  let fixture: ComponentFixture<SecondaryHorizontalCasualComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SecondaryHorizontalCasualComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SecondaryHorizontalCasualComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
