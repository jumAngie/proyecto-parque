import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlainLiveWidgetComponent } from './plain-live-widget.component';

describe('PlainLiveWidgetComponent', () => {
  let component: PlainLiveWidgetComponent;
  let fixture: ComponentFixture<PlainLiveWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [PlainLiveWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlainLiveWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
