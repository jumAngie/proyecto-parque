import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { WeeklySalesWidgetComponent } from './weekly-sales-widget.component';

describe('WeeklySalesWidgetComponent', () => {
  let component: WeeklySalesWidgetComponent;
  let fixture: ComponentFixture<WeeklySalesWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [WeeklySalesWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WeeklySalesWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
