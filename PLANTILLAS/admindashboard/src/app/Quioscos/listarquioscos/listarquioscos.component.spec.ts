import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListarquioscosComponent } from './listarquioscos.component';

describe('ListarquioscosComponent', () => {
  let component: ListarquioscosComponent;
  let fixture: ComponentFixture<ListarquioscosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListarquioscosComponent]
    });
    fixture = TestBed.createComponent(ListarquioscosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
