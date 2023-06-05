import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TemporizadoresListadoComponent } from './temporizadores-listado.component';

describe('TemporizadoresListadoComponent', () => {
  let component: TemporizadoresListadoComponent;
  let fixture: ComponentFixture<TemporizadoresListadoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TemporizadoresListadoComponent]
    });
    fixture = TestBed.createComponent(TemporizadoresListadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
