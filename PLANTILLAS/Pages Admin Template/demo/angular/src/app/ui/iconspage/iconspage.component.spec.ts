import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IconspageComponent } from './iconspage.component';

describe('IconspageComponent', () => {
  let component: IconspageComponent;
  let fixture: ComponentFixture<IconspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [IconspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IconspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
