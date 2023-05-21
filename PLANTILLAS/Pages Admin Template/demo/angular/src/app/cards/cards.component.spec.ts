import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CardsComponentPage } from './cards.component';

describe('CardsComponent', () => {
  let component: CardsComponentPage;
  let fixture: ComponentFixture<CardsComponentPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CardsComponentPage]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CardsComponentPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
