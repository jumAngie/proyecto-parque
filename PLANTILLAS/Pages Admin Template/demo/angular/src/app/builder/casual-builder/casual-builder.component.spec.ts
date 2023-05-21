import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CasualBuilderComponent } from './casual-builder.component';

describe('CasualBuilderComponent', () => {
  let component: CasualBuilderComponent;
  let fixture: ComponentFixture<CasualBuilderComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CasualBuilderComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CasualBuilderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
