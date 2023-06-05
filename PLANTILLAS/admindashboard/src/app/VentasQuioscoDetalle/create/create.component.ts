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
  detalleDelete: VentasQuioscoDetalle = new VentasQuioscoDetalle();

  PagoRequerido = false;
  ClienteRequerido = false;
  InsumoRequerido = false;
  CantidadRequerido = false;

// DESHABILIDAR CAMPOS
  ClientesDDL_Disabled = false;
  PagoDDL_Disabled = false;
  btnCreateHeader_Disabled = false;
  btnGoBack_Disabled = false;

  InsumosDDL_Disabled = false;
  Cantidad_Disabled = false;
  btnSendDetails = false;
  btnCloseReceipt = false;
  
  showModedData: VentasQuioscoDetalle[] = [];
  filtro: String = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2, 
  ){}

  ngOnInit(): void {
    
    this.quioscoID = 1;
    this.venta.clie_ID = 2;
    this.venta.pago_ID = 0;
    this.detalle.insu_ID = 0;


    this.getPagos();
    this.getClientes();
    this.getInsumos();  
    this.disableFields(false);
    this.disableContentFields(true);
  };

  filtrarInsumos(){
    const filtroLowerCase = this.filtro.toLowerCase();

    return this.showDetalles.filter(detalle => {
        const nombreValido = detalle.golo_Nombre.toLowerCase().includes(filtroLowerCase);
        const direccionValido = detalle.golo_Precio.toString().toLowerCase().includes(filtroLowerCase);
        const areaNombreValido = detalle.deta_Cantidad.toString().toLowerCase().includes(filtroLowerCase);
        const totalProds = detalle.valorFinalPorInsumo.toString().toLowerCase().includes(filtroLowerCase);
        return nombreValido || direccionValido || areaNombreValido || totalProds
    });    
  }


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
  };

  reloadDetails(){
    this.service.getDetallesByVenta(this.detalle.vent_ID).subscribe((response : any) =>{      
      if (response.success) {
        this.showDetalles = response.data;

        for (let i = 0; i < this.showDetalles.length; i++) {
          const showDetalleItem = this.showDetalles[i];
          showDetalleItem.valorFinalPorInsumo = showDetalleItem.golo_Precio * showDetalleItem.deta_Cantidad;
        }
        
        const Subtotal = this.showDetalles.reduce((total, detalleItem) => total + detalleItem.valorFinalPorInsumo, 0);
        const ISV = (Subtotal * 0.15).toFixed(2);
        const GranTotal = (parseFloat(Subtotal.toString()) + parseFloat(ISV.toString())).toFixed(2);

        this.totalRow = {
          vent_Subtotal: Subtotal,
          vent_ISV: ISV,
          vent_GranTotal: GranTotal,
        };

      };
    });
  }
//#endregion

//#region HABILITAR, DESHABILITAR Y LIMPIAR INPUTS
  disableFields(x: boolean){
    const ClientesDDL = this.elementRef.nativeElement.querySelector('#clie_ID');
    this.renderer2.setProperty(ClientesDDL, 'disabled', x);
    this.ClientesDDL_Disabled = x;

    const PagosDDL = this.elementRef.nativeElement.querySelector('#pago_ID');
    this.renderer2.setProperty(PagosDDL, 'disabled', x);
    this.PagoDDL_Disabled = x;

    const btnCreateHeader = this.elementRef.nativeElement.querySelector('#btnCreateHeader');
    this.renderer2.setProperty(btnCreateHeader, 'disabled', x);
    this.btnCreateHeader_Disabled = x;

    const btnGoBack = this.elementRef.nativeElement.querySelector('#btnGoBack');
    this.renderer2.setProperty(btnGoBack, 'disabled', x);
    this.btnGoBack_Disabled = x;
  };

  disableContentFields(x: boolean){
    const InsumosDDL = this.elementRef.nativeElement.querySelector('#insu_ID');
    this.renderer2.setProperty(InsumosDDL, 'disabled', x);
    this.InsumosDDL_Disabled = x;

    const Cantidad = this.elementRef.nativeElement.querySelector('#deta_Cantidad');
    this.renderer2.setProperty(Cantidad, 'disabled', x);
    this.Cantidad_Disabled = x;

    const btnCloseReceipt = this.elementRef.nativeElement.querySelector('#btnCloseReceipt');
    this.renderer2.setProperty(btnCloseReceipt, 'disabled', x);
    this.btnCloseReceipt = x;

    const btnSendDetails = this.elementRef.nativeElement.querySelector('#btnSendDetails');
    this.renderer2.setProperty(btnSendDetails, 'disabled', x);
    this.btnSendDetails = x;
  };

  clearContentInputs(){
    const InsumosDDL = this.elementRef.nativeElement.querySelector('#insu_ID');
    this.renderer2.setProperty(InsumosDDL, 'value', '');

    const Cantidad = this.elementRef.nativeElement.querySelector('#deta_Cantidad');
    this.renderer2.setProperty(Cantidad, 'value', '');

    this.detalle.insu_ID = 0;
    this.detalle.deta_Cantidad == null;
  };

  closeModal(){
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.removeClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'none');    
  }


//#endregion
  

//#region ENVIAR DATOS 

  GuardarVenta(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    errorsArray[0] = this.validarPago();
    errorsArray[1] = this.validarCliente();

    for (let i = 0; i < errorsArray.length; i++) {
      if (errorsArray[i] == true) {errors++; }
      else {errors; };      
    };

    if(this.ClientesDDL_Disabled && this.PagoDDL_Disabled){
      ToastUtils.showWarningToast('Pero que haces washin');
    }
    else{
      if (errors == 0) {      
        const usua_ID = localStorage.getItem('usua_ID');
        if (usua_ID == null) {
          this.router.navigate(['pages-login']);
        }  
        this.venta.vent_UsuarioCreador = parseInt(usua_ID ?? '');
        this.venta.quio_ID = this.quioscoID;

        this.service.createVenta(this.venta).subscribe((response : any) =>{
          if (response.code == 200) {
            ToastUtils.showSuccessToast('Factura creada con éxito!');

            this.detalle.vent_ID = response.message.toString();
            this.disableFields(true);
            this.disableContentFields(false);
          }else if(response.code == 409){
            ToastUtils.showWarningToast(response.message);
          }else{
            ToastUtils.showErrorToast(response.message);
          }
        })
      }else{
        ToastUtils.showWarningToast('Hay campos vacíos!');
      };
    };
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
      };
    };

    if(this.InsumosDDL_Disabled && this.Cantidad_Disabled){
      ToastUtils.showWarningToast('Anda pasha bobo');
    }else{

      if (errors == 0) {
        const usua_ID = localStorage.getItem('usua_ID');
        if (usua_ID == null) {
          this.router.navigate(['pages-login']);
        }        
        this.detalle.deta_UsuarioCreador = parseInt(usua_ID ?? '');
        this.service.createVentaDetalle(this.detalle).subscribe((response : any) =>{
          if (response.code == 200) {
            this.clearContentInputs();
            ToastUtils.showSuccessToast(response.message);
  
            this.reloadDetails();
  
          }else if(response.code == 409){
            ToastUtils.showWarningToast(response.message);
          }else{
            ToastUtils.showErrorToast(response.message);
          };
        });
      }else{
        ToastUtils.showWarningToast('Hay campos vacios!')
      };
    };
  };

  onDeleteDetail(rowData: any): void{
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.addClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'block');
    this.detalleDelete = rowData;
  };

  confirmDeleteDetail(){
    this.service.deleteInsumo(this.detalleDelete).subscribe((response : any) =>{
      if(response.code == 200){
        this.reloadDetails();
        ToastUtils.showSuccessToast(response.message);
      }else if(response.code == 409){
        ToastUtils.showWarningToast(response.message);
      }else{
        ToastUtils.showErrorToast(response.message);
      }
    })
    this.closeModal();
  }
  
  Volver(){
    this.router.navigate(['ventasquiosco-listado']);
  };

  closeReceipt(){
    ToastUtils.showSuccessToast('Venta finalizada exitosamente!');
    this.router.navigate(['ventasquiosco-listado']);
  }

//#endregion



//#region VALIDACIONES DEL ENCABEZADO DE LA FACTURA


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
    if (!this.detalle.insu_ID || this.detalle.insu_ID.toString().trim() == '' || this.detalle.insu_ID == 0) {
      this.InsumoRequerido = true
      return true;
    }else{
      this.InsumoRequerido = false;
      return false;
    }
  };

  validarCantidad(){
    const regex = /^[0-9]+(\.[0-9]{1,2})?$/;

    if (!this.detalle.deta_Cantidad || this.detalle.deta_Cantidad.toString().trim() == '') {
      this.CantidadRequerido = true;
      return true;
    }else if(!regex.test(this.detalle.deta_Cantidad.toString())){
      this.CantidadRequerido = true;
      ToastUtils.showWarningToast('Solo se aceptan valores numéricos.')
      return true;      
    }else if(this.detalle.deta_Cantidad <= 1){      
      this.CantidadRequerido = true;
      ToastUtils.showWarningToast('Cantidad no puede ser menor a uno .')
      return true;      
    }
    else{
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
