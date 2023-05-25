import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditarempleadosComponent } from './editarempleados.component';

describe('EditarempleadosComponent', () => {
  let component: EditarempleadosComponent;
  let fixture: ComponentFixture<EditarempleadosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EditarempleadosComponent]
    });
    fixture = TestBed.createComponent(EditarempleadosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
