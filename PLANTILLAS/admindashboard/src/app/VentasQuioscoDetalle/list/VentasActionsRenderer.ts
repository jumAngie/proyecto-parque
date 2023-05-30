import { Component } from '@angular/core';

@Component({
    selector: 'app-actions-renderer',
    styleUrls: ['./list.component.css'],
    template: `
      
      <button class="ov-btn-grow-u ms-2" style="height: 40px;" (click)="onEditClick()"><i class="bi bi-pencil-square"></i> <label class="ms-1">Editar</label> </button>
      <button class="ov-btn-grow-primary ms-2" style="height: 40px;" (click)="onDetailClick()"><i class="bi bi-eye-fill"></i> <label class="ms-1">Detalle</label> </button>
      <button class="ov-btn-grow-d ms-2" style="height: 40px;" (click)="onDeleteClick()"><i class="bi bi-trash-fill"></i> <label class="ms-1">Eliminar</label> </button>
    `
})

export class VetasActionsRenderer{
    params: any;
    
    agInit(params: any): void{
        this.params = params;
    };

    onEditClick(): void{
        this.params.onEdit(this.params.data);
    };

    onDeleteClick(): void{
        this.params.onDelete(this.params.data);  
    };

    onDetailClick(): void{
        this.params.onDetail(this.params.data);
    };

};
