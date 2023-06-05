import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FilasListadoComponent } from './filas-listado.component';

describe('FilasListadoComponent', () => {
  let component: FilasListadoComponent;
  let fixture: ComponentFixture<FilasListadoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [FilasListadoComponent]
    });
    fixture = TestBed.createComponent(FilasListadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
