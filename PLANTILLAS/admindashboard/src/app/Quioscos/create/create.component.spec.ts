import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateQuioscoComponent } from './create.component';

describe('CreateQuioscoComponent', () => {
  let component: CreateQuioscoComponent;
  let fixture: ComponentFixture<CreateQuioscoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreateQuioscoComponent]
    });
    fixture = TestBed.createComponent(CreateQuioscoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
