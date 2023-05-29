import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListticketsComponent } from './listtickets.component';

describe('ListticketsComponent', () => {
  let component: ListticketsComponent;
  let fixture: ComponentFixture<ListticketsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListticketsComponent]
    });
    fixture = TestBed.createComponent(ListticketsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
