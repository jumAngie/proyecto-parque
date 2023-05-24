import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditarcargosComponent } from './editarcargos.component';

describe('EditarcargosComponent', () => {
  let component: EditarcargosComponent;
  let fixture: ComponentFixture<EditarcargosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditarcargosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditarcargosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
