import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { NotificationspageComponent } from './notificationspage.component';

describe('NotificationspageComponent', () => {
  let component: NotificationspageComponent;
  let fixture: ComponentFixture<NotificationspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [NotificationspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NotificationspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
