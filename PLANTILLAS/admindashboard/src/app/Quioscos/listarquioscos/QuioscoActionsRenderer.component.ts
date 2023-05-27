import { Component } from '@angular/core';

@Component({
    selector: 'app-actions-renderer',
    styleUrls: ['./listarquioscos.component.css'],
    template: `
      
      <button class="ov-btn-grow-primary" style="height: 40px;" (click)="onDetailClick()"><i class="bi bi-eye-fill"></i> <label class="ms-1">Detalle</label> </button>
      <button class="ov-btn-grow-u ms-2" style="height: 40px;" (click)="onEditClick()"><i class="bi bi-pencil-square"></i> <label class="ms-1">Editar</label> </button>
      <button class="ov-btn-grow-d ms-2" style="height: 40px;" (click)="onDeleteClick()"><i class="bi bi-trash-fill"></i> <label class="ms-1">Eliminar</label> </button>
      
      <span (click)="toggleDetails($event)">
  <i [class]="'fa ' + (expanded ? 'fa-minus' : 'fa-plus')"></i>
</span>
      
      <!-- <button class="ov-btn-grow-d" data-bs-toggle="modal" data-bs-target="#disablebackdrop"><i class="bi bi-trash-fill" ></i></button>
  
      <div class="modal fade" id="disablebackdrop" tabindex="-1" >
        <div class="modal-dialog modal-dialog-centered">
           <div class="modal-content">
              <div class="modal-header bg-danger">
                 <h5 class="modal-title text-light">Confirmar Eliminación</h5>               
              </div>
              <div class="modal-body text-center text-dark"> ¿Está seguro que desea eliminar esta atracción?</div>
              <div class="modal-footer"> 
                 <button type="button" class="ov-btn-grow-d mb-2 mt-3 col-3" style="height: 2.4rem; margin-left: 0;" data-bs-dismiss="modal">
                    <i class="bi bi-reply-fill"></i>Cancelar
                 </button> 
                 <button class="ov-btn-grow-in mb-2 mt-3 col-3" style="height: 2.4rem; margin-left: 0;" data-bs-dismiss="modal">
                    <i class="bi bi-check-circle-fill "></i>Eliminar
                 </button>
              </div>
           </div>
        </div>
     </div> -->
    `
})

export class QuioscoActionsRenderer{
    params: any;
    public expanded = false;

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

    refresh(params: any): boolean {
      return false;
    }
  
    toggleDetails(event: any): void {
      this.expanded = !this.expanded;
      // Puedes emitir un evento aquí para notificar a la tabla principal sobre el cambio en el estado de los detalles
    }
};
