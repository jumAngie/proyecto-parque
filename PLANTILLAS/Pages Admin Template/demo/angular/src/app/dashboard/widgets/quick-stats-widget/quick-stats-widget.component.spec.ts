import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { QuickStatsWidgetComponent } from './quick-stats-widget.component';

describe('QuickStatsWidgetComponent', () => {
  let component: QuickStatsWidgetComponent;
  let fixture: ComponentFixture<QuickStatsWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [QuickStatsWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(QuickStatsWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
