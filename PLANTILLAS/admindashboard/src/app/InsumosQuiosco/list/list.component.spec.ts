import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListInsumosQuioscoComponent } from './list.component';

describe('ListInsumosQuioscoComponent', () => {
  let component: ListInsumosQuioscoComponent;
  let fixture: ComponentFixture<ListInsumosQuioscoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListInsumosQuioscoComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListInsumosQuioscoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
