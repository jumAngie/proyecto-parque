import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ModalspageComponent } from './modalspage.component';

describe('ModalspageComponent', () => {
  let component: ModalspageComponent;
  let fixture: ComponentFixture<ModalspageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ModalspageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ModalspageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
