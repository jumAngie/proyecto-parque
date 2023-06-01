import { Component, OnInit, ElementRef, Renderer2 } from '@angular/core';
import { Router, TitleStrategy } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { GridOptions, GridApi, ColumnApi } from 'ag-grid-community';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { VetasActionsRenderer } from './VentasActionsRenderer';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})

export class VentasListComponent implements OnInit {
  ventasQuioscoDetalle!: VentasQuioscoDetalle[];
  deleteID: any;
  gridOptions: GridOptions = {};
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10, 20, 30]; // Opciones de tamaño de página

  constructor(
    private service: ParqServicesService, 
    private router: Router
  ) { }

  ngOnInit(): void {
    this.gridOptions = {
      columnDefs: [
        {headerName: 'Venta #: ', field: 'vent_ID', width: 150, autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Método de págo', field: 'pago_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Fecha', field: 'vent_FechaCreacion', width: 300, autoHeight: true, autoHeaderHeight: true},
        {
          headerName: 'Acciones',
          width: 350, 
          sortable: false,
          filter: false,
          cellRenderer: 'actionsRenderer',
          cellRendererParams: {
            onDetail: this.onDetail.bind(this),
            onEdit: this.onEdit.bind(this),
            onDelete: this.onDelete.bind(this),
          }
        },
      ],            
      rowData: this.ventasQuioscoDetalle,
      pagination: true,
      paginationPageSize: this.selectedPageSize,
      context: {
        pageSizeOptions: this.pageSizeOptions
      },
      defaultColDef: {
        sortable: true,
        lockVisible: true,
        filter: true,
        resizable: true,
        unSortIcon: true,
        wrapHeaderText: true,
        wrapText: true,
      },
      frameworkComponents: {
        actionsRenderer: VetasActionsRenderer,
      },
      localeText: {
        // Encabezados de columna
        columnMenuName: 'Menú de columnas',
        columnHide: 'Ocultar',
        columnShowAll: 'Mostrar todo',
        columnDefs: 'Definiciones de columnas',
        // Otros textos
        loadingOoo: 'Cargando...',
        noRowsToShow: 'No hay filas para mostrar',
        page: 'Página',
        more: 'Más',
        to: 'a',
        of: 'de',
        next: 'Siguiente',
        last: 'Último',
        first: 'Primero',
        previous: 'Anterior', 
      },
    }

    this.getVentas();
    this.onPageSizeChanged();
  }

  onPageSizeChanged(): void {
    this.gridOptions.api?.paginationSetPageSize(this.selectedPageSize);
  }
  

  getVentas(){
    this.service.getVentas()
    .subscribe((response: any) => {
      if(response.success){
        this.ventasQuioscoDetalle = response.data;
        this.gridOptions.api?.setRowData(this.ventasQuioscoDetalle);
      }
    })
  }


  Agregar(){
    this.router.navigate(['ventasquiosco-crear']);
  };

  onDetail(rowData: any): void{    
    localStorage.setItem('venta', JSON.stringify(rowData));    
    this.router.navigate(['ventasquiosco-detalle']);
  }

  onEdit(rowData: any): void {
     ToastUtils.showErrorToast('Esta factura ya ha sido finalizada, imposible editar.')
  }
  
  onDelete(rowData: any): void {
    ToastUtils.showErrorToast('Esta factura ya ha sido finalizada, imposible eliminar')
  }
}
