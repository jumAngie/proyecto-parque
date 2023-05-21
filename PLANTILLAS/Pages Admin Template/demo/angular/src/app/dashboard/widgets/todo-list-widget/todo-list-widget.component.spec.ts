import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TodoListWidgetComponent } from './todo-list-widget.component';

describe('TodoListWidgetComponent', () => {
  let component: TodoListWidgetComponent;
  let fixture: ComponentFixture<TodoListWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TodoListWidgetComponent]
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TodoListWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
