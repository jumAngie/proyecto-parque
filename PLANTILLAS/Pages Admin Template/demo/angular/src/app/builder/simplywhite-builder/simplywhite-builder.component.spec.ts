import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SimplywhiteBuilderComponent } from './simplywhite-builder.component';

describe('SimplywhiteBuilderComponent', () => {
  let component: SimplywhiteBuilderComponent;
  let fixture: ComponentFixture<SimplywhiteBuilderComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SimplywhiteBuilderComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SimplywhiteBuilderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
