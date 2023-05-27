import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditQuioscoComponent } from './edit.component';

describe('EditQuioscoComponent', () => {
  let component: EditQuioscoComponent;
  let fixture: ComponentFixture<EditQuioscoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EditQuioscoComponent]
    });
    fixture = TestBed.createComponent(EditQuioscoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
