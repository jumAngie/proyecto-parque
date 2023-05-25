import { Component } from '@angular/core';
import { ICellRendererAngularComp } from 'ag-grid-angular';
import { ICellRendererParams } from 'ag-grid-community';

@Component({
  selector: 'app-detail-cell-renderer',
  template: `
    <div>
      <!-- Aquí puedes mostrar los detalles del maestro -->
    </div>
  `,
})
export class DetailCellRendererComponent implements ICellRendererAngularComp {
  // Implementa los métodos de la interfaz ICellRendererAngularComp
  agInit(params: ICellRendererParams<any, any, any>): void {
      
  }

  refresh(params: ICellRendererParams<any, any, any>): any {
      
  }
}
