import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateticketsclienteComponent } from './createticketscliente.component';

describe('CreateticketsclienteComponent', () => {
  let component: CreateticketsclienteComponent;
  let fixture: ComponentFixture<CreateticketsclienteComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreateticketsclienteComponent]
    });
    fixture = TestBed.createComponent(CreateticketsclienteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
