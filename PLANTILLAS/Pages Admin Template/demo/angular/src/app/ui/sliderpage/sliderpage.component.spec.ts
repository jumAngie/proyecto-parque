import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SliderpageComponent } from './sliderpage.component';

describe('SliderpageComponent', () => {
  let component: SliderpageComponent;
  let fixture: ComponentFixture<SliderpageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SliderpageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SliderpageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
