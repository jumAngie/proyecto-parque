import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ImageWidgetComponent } from './image-widget.component';

describe('ImageWidgetComponent', () => {
  let component: ImageWidgetComponent;
  let fixture: ComponentFixture<ImageWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ImageWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ImageWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
