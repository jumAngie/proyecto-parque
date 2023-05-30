import { Component, OnInit } from '@angular/core';
import { InsumosQuiosco } from 'src/app/Models/InsumosQuiosco';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { GridOptions } from 'ag-grid-community';
import { ActionsRendererComponent } from './actionsRendererComponent.component';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListInsumosQuioscoComponent implements OnInit {
  insumosQuiosco: InsumosQuiosco[] = [];
  gridOptions: GridOptions = {};

  constructor(
    private service: ParqServicesService, 
    private router: Router    
  ) { }

  ngOnInit(): void {
    this.gridOptions = {
      columnDefs: [
        { headerName: 'Quiosco', field: 'quio_Nombre' },
        { headerName: 'Insumo', field: 'golo_Nombre' },
        {
          headerName: 'Acciones',
          cellRenderer: 'actionsRenderer',
          cellRendererParams: {
            onEdit: this.onEdit.bind(this),
            onDelete: this.onDelete.bind(this)
          }
        }
      ],
      rowData: this.insumosQuiosco,
      defaultColDef: {
        sortable: true,
        filter: true,
      },
      frameworkComponents: {
        actionsRenderer: ActionsRendererComponent
      }
    };
    
    this.getData();
  }
  
  getData(): void {
    this.service.getInsumosQuiosco().subscribe((response: any) => {
      if (response.success) {
        this.insumosQuiosco = response.data;
        this.gridOptions.api?.setRowData(this.insumosQuiosco);
      }
    });
  };


  onEdit(rowData: any): void {
    // Lógica para editar el registro
  }
  
  onDelete(rowData: any): void {
    // Lógica para eliminar el registro
  }
  
}
