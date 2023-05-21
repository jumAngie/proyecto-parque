import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { GraphLiveWidgetComponent } from './graph-live-widget.component';

describe('GraphLiveWidgetComponent', () => {
  let component: GraphLiveWidgetComponent;
  let fixture: ComponentFixture<GraphLiveWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [GraphLiveWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GraphLiveWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
