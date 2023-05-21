import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { GraphTileWidgetComponent } from './graph-tile-widget.component';

describe('GraphTileWidgetComponent', () => {
  let component: GraphTileWidgetComponent;
  let fixture: ComponentFixture<GraphTileWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [GraphTileWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GraphTileWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
