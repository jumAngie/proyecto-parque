import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProjectProgressWidgetComponent } from './project-progress-widget.component';

describe('ProjectProgressWidgetComponent', () => {
  let component: ProjectProgressWidgetComponent;
  let fixture: ComponentFixture<ProjectProgressWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ProjectProgressWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProjectProgressWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
