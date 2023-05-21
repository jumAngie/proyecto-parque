import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RootbuilderComponent } from './rootbuilder.component';

describe('RootbuilderComponent', () => {
  let component: RootbuilderComponent;
  let fixture: ComponentFixture<RootbuilderComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [RootbuilderComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RootbuilderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
