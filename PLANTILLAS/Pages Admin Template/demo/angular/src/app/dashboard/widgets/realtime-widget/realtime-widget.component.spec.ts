import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RealtimeWidgetComponent } from './realtime-widget.component';

describe('RealtimeWidgetComponent', () => {
  let component: RealtimeWidgetComponent;
  let fixture: ComponentFixture<RealtimeWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [RealtimeWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RealtimeWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
