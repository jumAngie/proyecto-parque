import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListempleadosComponent } from './listempleados.component';

describe('ListempleadosComponent', () => {
  let component: ListempleadosComponent;
  let fixture: ComponentFixture<ListempleadosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListempleadosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListempleadosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
