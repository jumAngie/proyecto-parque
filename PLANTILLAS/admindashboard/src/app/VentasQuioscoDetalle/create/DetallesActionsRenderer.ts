import { Component } from '@angular/core';

@Component({
    selector: 'app-actions-renderer',
    styleUrls: ['./create.component.css'],
    template: `
        <button class="ov-btn-grow-d ms-2" style="height: 40px;" (click)="onDeleteClick()">
        <i class="bi bi-trash-fill"></i>
        <label class="ms-1">Eliminar</label> 
        </button>
    `
})

export class DetallesActionsRenderer{
    params: any;
    
    agInit(params: any): void{
        this.params = params;
    };

    onEditClick(): void{
        this.params.onEdit(this.params.data);
    };

    onDeleteClick(): void{
        this.params.onDeleteDetail(this.params.data);  
    };

    onDetailClick(): void{
        this.params.onDetail(this.params.data);
    };

};
