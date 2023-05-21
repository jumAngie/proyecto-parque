import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BarTileWidgetComponent } from './bar-tile-widget.component';

describe('BarTileWidgetComponent', () => {
  let component: BarTileWidgetComponent;
  let fixture: ComponentFixture<BarTileWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [BarTileWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BarTileWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
