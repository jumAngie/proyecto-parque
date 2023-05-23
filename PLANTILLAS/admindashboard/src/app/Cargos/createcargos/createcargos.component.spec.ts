import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreatecargosComponent } from './createcargos.component';

describe('CreatecargosComponent', () => {
  let component: CreatecargosComponent;
  let fixture: ComponentFixture<CreatecargosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CreatecargosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CreatecargosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
