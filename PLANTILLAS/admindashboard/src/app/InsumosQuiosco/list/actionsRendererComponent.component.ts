import { Component } from '@angular/core';

@Component({
  selector: 'app-actions-renderer',
  styleUrls: ['./list.component.css'],
  template: `
    <button class="ov-btn-grow-u" (click)="onEditClick()">Editar</button>
    <button class="ov-btn-grow-d" (click)="onDeleteClick()">Eliminar</button>
  `
})
export class ActionsRendererComponent {
  params: any;

  agInit(params: any): void {
    this.params = params;
  }

  onEditClick(): void {
    this.params.onEdit(this.params.data);
  }

  onDeleteClick(): void {
    this.params.onDelete(this.params.data);
  }
}
