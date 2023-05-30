import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListticketsclienteComponent } from './listticketscliente.component';

describe('ListticketsclienteComponent', () => {
  let component: ListticketsclienteComponent;
  let fixture: ComponentFixture<ListticketsclienteComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListticketsclienteComponent]
    });
    fixture = TestBed.createComponent(ListticketsclienteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
