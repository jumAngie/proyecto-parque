import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListAtraccionesComponent } from './list.component';

describe('ListAtraccionesComponent', () => {
  let component: ListAtraccionesComponent;
  let fixture: ComponentFixture<ListAtraccionesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListAtraccionesComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListAtraccionesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
