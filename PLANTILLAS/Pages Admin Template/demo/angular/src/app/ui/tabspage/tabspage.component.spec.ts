import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TabspageComponent } from './tabspage.component';

describe('TabspageComponent', () => {
  let component: TabspageComponent;
  let fixture: ComponentFixture<TabspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TabspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TabspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
