import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DibujadomapaComponent } from './dibujadomapa.component';

describe('DibujadomapaComponent', () => {
  let component: DibujadomapaComponent;
  let fixture: ComponentFixture<DibujadomapaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DibujadomapaComponent]
    });
    fixture = TestBed.createComponent(DibujadomapaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
