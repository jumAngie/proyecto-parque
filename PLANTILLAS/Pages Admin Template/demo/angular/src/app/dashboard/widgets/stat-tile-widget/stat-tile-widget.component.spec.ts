import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { StatTileWidgetComponent } from './stat-tile-widget.component';

describe('StatTileWidgetComponent', () => {
  let component: StatTileWidgetComponent;
  let fixture: ComponentFixture<StatTileWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [StatTileWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StatTileWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
