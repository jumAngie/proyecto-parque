import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListgolosinasComponent } from './listgolosinas.component';

describe('ListgolosinasComponent', () => {
  let component: ListgolosinasComponent;
  let fixture: ComponentFixture<ListgolosinasComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListgolosinasComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListgolosinasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
