import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TreeviewpageComponent } from './treeviewpage.component';

describe('TreeviewpageComponent', () => {
  let component: TreeviewpageComponent;
  let fixture: ComponentFixture<TreeviewpageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TreeviewpageComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TreeviewpageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
