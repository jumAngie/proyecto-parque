import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateticketsComponent } from './createtickets.component';

describe('CreateticketsComponent', () => {
  let component: CreateticketsComponent;
  let fixture: ComponentFixture<CreateticketsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreateticketsComponent]
    });
    fixture = TestBed.createComponent(CreateticketsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
