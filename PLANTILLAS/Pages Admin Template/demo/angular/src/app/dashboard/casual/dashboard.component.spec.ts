import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CasualDashboardComponent } from './dashboard.component';

describe('CasualDashboardComponent', () => {
  let component: CasualDashboardComponent;
  let fixture: ComponentFixture<CasualDashboardComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CasualDashboardComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CasualDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
