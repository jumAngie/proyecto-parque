import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListcargosComponent } from './listcargos.component';

describe('ListcargosComponent', () => {
  let component: ListcargosComponent;
  let fixture: ComponentFixture<ListcargosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListcargosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListcargosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
