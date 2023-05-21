import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SocialPostTileWidgetComponent } from './social-post-tile-widget.component';

describe('SocialPostTileWidgetComponent', () => {
  let component: SocialPostTileWidgetComponent;
  let fixture: ComponentFixture<SocialPostTileWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SocialPostTileWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SocialPostTileWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
