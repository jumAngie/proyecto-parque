import { Component } from '@angular/core';

@Component({
  selector: 'app-actions-renderer',
  styleUrls: ['./list.component.css'],
  template: `
    <button class="ov-btn-grow-u" (click)="onEditClick()">Editar</button>
    <button class="ov-btn-grow-d" (click)="onDeleteClick()">Eliminar</button>
    <button class="ov-btn-grow-d" data-bs-toggle="modal" data-bs-target="#disablebackdrop"><i class="bi bi-trash-fill" ></i></button>

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
   </div>
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
