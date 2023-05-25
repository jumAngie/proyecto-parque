import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListarmetodosComponent } from './listarmetodos.component';

describe('ListarmetodosComponent', () => {
  let component: ListarmetodosComponent;
  let fixture: ComponentFixture<ListarmetodosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListarmetodosComponent]
    });
    fixture = TestBed.createComponent(ListarmetodosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
