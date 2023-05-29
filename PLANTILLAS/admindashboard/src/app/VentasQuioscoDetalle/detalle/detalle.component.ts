import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { GridOptions } from 'ag-grid-community';
import { VentasQuiosco } from 'src/app/Models/VentasQuiosco';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';


@Component({
  selector: 'app-detalle',
  templateUrl: './detalle.component.html',
  styleUrls: ['./detalle.component.css']
})
export class VentasDetalleComponent implements OnInit{
  venta: VentasQuiosco = new VentasQuiosco();
  detalle!: VentasQuioscoDetalle[];
  gridOptions: GridOptions = {};
  totalRow: any = {};

  constructor(
    private service: ParqServicesService,
    private router: Router,
    
  ){}

  ngOnInit(): void {
    this.gridOptions = {
      columnDefs: [        
        {headerName: 'Golosina', field: 'golo_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Precio unitario', field: 'golo_Precio', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Cantidad', field: 'deta_Cantidad',  autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Valor', field: 'valorFinalPorInsumo'},
      ],
      columnHoverHighlight: true,    
        
      rowData: this.detalle,
      pagination: true,
      paginationPageSize: 7,   
      defaultColDef: {
        sortable: true,
        filter: true,
        resizable: true,
        unSortIcon: true,
        wrapHeaderText: true,
        wrapText: true,
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
    };

    this.venta = JSON.parse(localStorage.getItem('venta') ?? '')
    console.log(this.venta);

    this.getDetalles();
  }



  getDetalles(){
    this.service.getDetallesByVenta(this.venta.vent_ID).subscribe((response : any) =>{
      console.log(response);
      if(response.success){
        this.detalle = response.data;

        const detalleTransformado: VentasQuioscoDetalle[] = [];

        for (let i = 0; i < this.detalle.length; i++) {
          const detalleItem = this.detalle[i];

          const detaleItemTransformado: VentasQuioscoDetalle = {
            deta_ID: detalleItem.deta_ID,
            vent_ID: detalleItem.vent_ID,
            insu_ID: detalleItem.insu_ID,
            golo_Nombre: detalleItem.golo_Nombre,
            golo_Precio: detalleItem.golo_Precio,
            deta_Cantidad: detalleItem.deta_Cantidad,
            deta_Habilitado: detalleItem.deta_Habilitado,
            deta_Estado: detalleItem.deta_Estado,
            empl_crea: detalleItem.empl_crea,
            empl_modifica: detalleItem.empl_modifica,
            deta_UsuarioCreador: detalleItem.deta_UsuarioCreador,
            deta_UsuarioCreador_Nombre: detalleItem.deta_UsuarioCreador_Nombre,
            deta_FechaCreacion: detalleItem.deta_FechaCreacion,
            deta_UsuarioModificador: detalleItem.deta_UsuarioModificador,
            deta_UsuarioModificador_Nombre: detalleItem.deta_UsuarioCreador_Nombre,
            deta_FechaModificacion: detalleItem.deta_FechaModificacion,
            valorFinalPorInsumo: detalleItem.golo_Precio * detalleItem.deta_Cantidad
          }

          detalleTransformado.push(detaleItemTransformado);
        }
        this.gridOptions.api?.setRowData(detalleTransformado);

        const Subtotal = detalleTransformado.reduce((total, detalleItem) => total + detalleItem.valorFinalPorInsumo, 0);
        const ISV = Subtotal * 0.15;
        const GranTotal = Subtotal + ISV;

        this.totalRow = {
          vent_Subtotal: Subtotal,
          vent_ISV: ISV,
          vent_GranTotal: GranTotal,
        }

        console.log(this.totalRow);
      }
    })
  };

  Volver(){
    this.router.navigate(['ventasquiosco-listado']);
  }
}
