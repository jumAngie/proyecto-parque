import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SocialImageTileWidgetComponent } from './social-image-tile-widget.component';

describe('SocialImageTileWidgetComponent', () => {
  let component: SocialImageTileWidgetComponent;
  let fixture: ComponentFixture<SocialImageTileWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SocialImageTileWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SocialImageTileWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
