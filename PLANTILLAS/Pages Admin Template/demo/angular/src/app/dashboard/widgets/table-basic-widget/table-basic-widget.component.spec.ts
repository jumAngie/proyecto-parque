import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TableBasicWidgetComponent } from './table-basic-widget.component';

describe('TableBasicWidgetComponent', () => {
  let component: TableBasicWidgetComponent;
  let fixture: ComponentFixture<TableBasicWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TableBasicWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TableBasicWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
