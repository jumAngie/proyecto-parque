import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ViewsPageComponent } from './views.component';

describe('ViewsComponent', () => {
  let component: ViewsPageComponent;
  let fixture: ComponentFixture<ViewsPageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ViewsPageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ViewsPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
