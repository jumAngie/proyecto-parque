import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Pagos } from 'src/app/Models/Pagos';
import { VentasQuiosco } from 'src/app/Models/VentasQuiosco';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { Clientes } from 'src/app/Models/Clientes';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { GridOptions } from 'ag-grid-community';
import { InsumosQuiosco } from 'src/app/Models/InsumosQuiosco';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})

export class VentasCrearComponent implements OnInit{
  quioscoID: any;
  pagos!: Pagos[];
  clientes!: Clientes[];
  gridOptions: GridOptions = {};
  showDetalles!: VentasQuioscoDetalle[];
  insumos!: InsumosQuiosco[];
  totalRow: any = {};

  venta: VentasQuiosco = new VentasQuiosco();
  detalle: VentasQuioscoDetalle = new VentasQuioscoDetalle();
  
  PagoRequerido = false;
  ClienteRequerido = false;
  InsumoRequerido = false;
  CantidadRequerido = false;

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,

  ){}

  ngOnInit(): void {
    this.quioscoID = 1;
    this.venta.clie_ID = 1;

    this.loadTable();

    this.getPagos();
    this.getClientes();
    this.getInsumos();  

  };

//#region CARGAR DATOS
  getPagos(){
    this.service.getPagos().subscribe((response: any) =>{
      if(response.success){
        this.pagos = response.data;
      };
    });
  };

  getClientes(){
    this.service.getClientes().subscribe((response: any) =>{
      if (response.success) {
        this.clientes = response.data;
      }
    })
  };

  getInsumos(){
    this.service.getInsumosByQuisco(this.quioscoID).subscribe((response : any) =>{
      if (response.success) {
        this.insumos = response.data;
      }
    }) 
  }

  loadTable(){
    this.gridOptions = {
      columnDefs: [        
        {headerName: 'Golosina', field: 'golo_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Precio unitario', field: 'golo_Precio', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Cantidad', field: 'deta_Cantidad',  autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Valor', field: 'valorFinalPorInsumo'},
      ],
      columnHoverHighlight: true,          
      rowData: this.showDetalles,
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
        loadingOoo: 'Aún no hay registros por mostrar',
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
  }
//#endregion

  dissableFields(){
    const ClientesDDL = this.elementRef.nativeElement.querySelector('#clie_ID');
    this.renderer2.setProperty(ClientesDDL, 'disabled', true);

    const PagosDDL = this.elementRef.nativeElement.querySelector('#pago_ID');
    this.renderer2.setProperty(PagosDDL, 'disabled', true);
  }

//#region ENVIAR DATOS 

  GuardarVenta(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    errorsArray[0] = this.validarPago();
    errorsArray[1] = this.validarCliente();

    for (let i = 0; i < errorsArray.length; i++) {
      if (errorsArray[i] == true) {
          errors++;
      }else{
        errors;
      }      
    }

    if (errors == 0) {
      this.venta.vent_UsuarioCreador = 1;
      this.venta.quio_ID = 1;

      this.service.createVenta(this.venta).subscribe((response : any) =>{
        if (response.code == 200) {
          ToastUtils.showSuccessToast('Factura creada con éxito!');

          this.detalle.vent_ID = response.message.toString();
          this.dissableFields();
        }else if(response.code == 409){
          ToastUtils.showWarningToast(response.message);
        }else{
          ToastUtils.showErrorToast(response.message);
        }
      })
    }else{
      ToastUtils.showWarningToast('Hay campos vacíos!');
    }
  };

  GuardarDetalles(){
    var errors = 0;
    const errorsArray: boolean[] = [];

    errorsArray[0] = this.validarInsumo();
    errorsArray[1] = this.validarCantidad();

    for (let i = 0; i < errorsArray.length; i++) {
      if(errorsArray[i] == true){
        errors++;
      }else{
        errors;
      }
    }

    if (errors == 0) {
      this.detalle.deta_UsuarioCreador = 1;
      this.service.createVentaDetalle(this.detalle).subscribe((response : any) =>{
        if (response.code == 200) {
          ToastUtils.showSuccessToast(response.message);
          console.log(response);
          
          this.service.getDetallesByVenta(this.detalle.vent_ID).subscribe((response : any) =>{
            if (response.success) {
              this.showDetalles = response.data;

              const showModedData: VentasQuioscoDetalle[] = [];

              for (let i = 0; i < this.showDetalles.length; i++) {
                const showDetalleItem = this.showDetalles[i];

                const showTransformedData: VentasQuioscoDetalle = {
                  deta_ID: showDetalleItem.deta_ID,
                  vent_ID: showDetalleItem.vent_ID,
                  insu_ID: showDetalleItem.insu_ID,
                  golo_Nombre: showDetalleItem.golo_Nombre,
                  golo_Precio: showDetalleItem.golo_Precio,
                  deta_Cantidad: showDetalleItem.deta_Cantidad,
                  deta_Habilitado: showDetalleItem.deta_Habilitado,
                  deta_Estado: showDetalleItem.deta_Estado,
                  empl_crea: showDetalleItem.empl_crea,
                  empl_modifica: showDetalleItem.empl_modifica,
                  deta_UsuarioCreador: showDetalleItem.deta_UsuarioCreador,
                  deta_UsuarioCreador_Nombre: showDetalleItem.deta_UsuarioCreador_Nombre,
                  deta_FechaCreacion: showDetalleItem.deta_FechaCreacion,
                  deta_UsuarioModificador: showDetalleItem.deta_UsuarioModificador,
                  deta_UsuarioModificador_Nombre: showDetalleItem.deta_UsuarioCreador_Nombre,
                  deta_FechaModificacion: showDetalleItem.deta_FechaModificacion,
                  valorFinalPorInsumo: showDetalleItem.golo_Precio * showDetalleItem.deta_Cantidad                  
                };

                showModedData.push(showTransformedData);
              };

              this.gridOptions.api?.setRowData(showModedData);
              const Subtotal = showModedData.reduce((total, detalleItem) => total + detalleItem.valorFinalPorInsumo, 0);
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

        }else if(response.code == 409){
          ToastUtils.showWarningToast(response.message);
        }else{
          ToastUtils.showErrorToast(response.message);
        }
      })
    }
  };

//#endregion



//#region VALIDACIONES DEL ENCABEZADO DE LA FACTURA

  Volver(){
    this.router.navigate(['ventasquiosco-listado']);
  };

  validarPago(){
    if (!this.venta.pago_ID) {
      this.PagoRequerido = true;
      return true;
    }else{
      this.PagoRequerido = false;
      return false;
    }
  };

  validarCliente(){
    if (!this.venta.clie_ID) {
      this.ClienteRequerido = true;
      return true;
    }else{
      this.ClienteRequerido = false;
      return false;
    }
  };

  clearPagoError(){
    if (this.venta.pago_ID.toString().trim() !== '' || this.venta.pago_ID != 0) {
      this.PagoRequerido = false;
    }
  };

  clearClienteError(){
    if (this.venta.clie_ID.toString().trim() !== '' || this.venta.clie_ID != 0) {
      this.ClienteRequerido = false;
    }
  };
//#endregion


//#region VALIDACIONES DEL CONTENIDO DE LA FACTURA

  validarInsumo(){
    if (!this.detalle.insu_ID) {
      this.InsumoRequerido = true
      return true;
    }else{
      this.InsumoRequerido = false;
      return false;
    }
  };

  validarCantidad(){
    if (!this.detalle.deta_Cantidad) {
      this.CantidadRequerido = true;
      return true;
    }else{
      this.CantidadRequerido = false;
      return false;
    }
  };

  clearInsumoError(){
    if (this.detalle.insu_ID.toString().trim() !== '' || this.detalle.insu_ID != 0) {
      this.InsumoRequerido = false;
    }
  };

  clearCantidadError(){
    if (this.detalle.deta_Cantidad.toString().trim() !== '' || this.detalle.deta_Cantidad != 0) {
      this.CantidadRequerido = false;
    }
  }
//#endregion

};
