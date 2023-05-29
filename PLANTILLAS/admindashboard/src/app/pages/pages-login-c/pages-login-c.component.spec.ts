import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PagesLoginCComponent } from './pages-login-c.component';

describe('PagesLoginCComponent', () => {
  let component: PagesLoginCComponent;
  let fixture: ComponentFixture<PagesLoginCComponent>;

  beforeEach(async() => {
    await TestBed.configureTestingModule({
      declarations: [PagesLoginCComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PagesLoginCComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
