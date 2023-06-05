import { Component, ElementRef, OnInit, Renderer2, createEnvironmentInjector } from '@angular/core';
import { Router } from '@angular/router';
import { Clientes } from 'src/app/Models/Clientes';
import { FullTicktesCliente } from 'src/app/Models/FullTicketsCliente';
import { Pagos } from 'src/app/Models/Pagos';
import { TicketsCliente } from 'src/app/Models/TicketsCliente';
import { Ticket } from 'src/app/Models/Tikectks';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-createticketscliente',
  templateUrl: './createticketscliente.component.html',
  styleUrls: ['./createticketscliente.component.scss']
})
export class CreateticketsclienteComponent implements OnInit {
  ticketType!: Ticket[];
  clienteData: Clientes = new Clientes();
  searchCliente: Clientes = new Clientes();
  fullTicket: FullTicktesCliente = new FullTicktesCliente();
  pagos!: Pagos[];

  //CAMPOS DESHABILITADOS
  NombresDisabled = false;
  ApellidosDisabled = false;
  DniDisabled = false;
  TelefonoDisabled = false;
  Sexo1Disabled = false;
  Sexo2Disabled = false;


  //BUSQUEDA DE CLIENTE
  searchDNI_Requerido = false;  
  FormatoValidoDNIsearch = false;

  //VALIDACION DEL REGISTRO CLIENTE
  NombresRequerido = false;
  ApellidosRequerido = false;
  DNIRequerido = false;
  TelefonoRequerido = false;
  SexoRequerido = false;
  FormatoValidoTelefono = false;
  FormatoValidoDNI = false;

  //VALIDACION DE LA COMPRA TICKET
  selectedClassicTicket = 0;
  selectedVIPTicket = 0;
  cantidadClasicos =0
  cantidadClasicosRequerido = false;
  cantidadVIPRequerido = false;
  cantidadVIP = 0
  PagoRequerido = false;
  
  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2, 
  ){}

  ngOnInit(): void {
    this.ticketList(); 
    this.getPagos(); 
  }


//#region GET DATA
  ticketList(){
    this.service.getTicket()
    .subscribe((response: any) => {
    if (response.success) {
      this.ticketType = response.data;
    }
  });
  }

  getPagos(){
    this.service.getPagos().subscribe((response: any) =>{
      if(response.success){
        this.pagos = response.data;
      };
    });
  };
//#endregion

//#region DESHABILIDAR INPUTS 
  disableFields(x: boolean){
    const nombres = this.elementRef.nativeElement.querySelector('Nombres');
    this.renderer2.setProperty(nombres, 'disabled', x);
    this.NombresDisabled = x;

    const apellidos = this.elementRef.nativeElement.querySelector('Apellidos');
    this.renderer2.setProperty(apellidos, 'disabled', x);
    this.ApellidosDisabled = x;

    const dni = this.elementRef.nativeElement.querySelector('DNI');
    this.renderer2.setProperty(dni, 'disabled', x);
    this.DniDisabled = x;

    const telefono = this.elementRef.nativeElement.querySelector('Telefono');
    this.renderer2.setProperty(telefono, 'disabled', x);
    this.TelefonoDisabled = x;

    const rb1 = this.elementRef.nativeElement.querySelector('gridRadios1');
    this.renderer2.setProperty(rb1, 'disabled', x);
    this.Sexo1Disabled = x;

    const rb2 = this.elementRef.nativeElement.querySelector('gridRadios2');
    this.renderer2.setProperty(rb2, 'disabled', x);
    this.Sexo2Disabled = x;
  }

//#endregion

//#region BUSQUEDA DE CLIENTE POR SU DNI
  validar_searchDNI(){
    const dniPattern = /^\d{4}-\d{4}-\d{5}$/;

    if (!this.searchCliente.clie_DNI) {
      this.searchDNI_Requerido = true;
      return true;
    } else if (!dniPattern.test(this.searchCliente.clie_DNI)) {
      this.searchDNI_Requerido = true;
      this.FormatoValidoDNIsearch = true;
      ToastUtils.showWarningToast('Formato de DNI inválido. El formato debe ser XXXX-XXXX-XXXXX');
      return false;
    } else {
      this.searchDNI_Requerido = false;
      this.FormatoValidoDNIsearch = false;
      return false;
    }
  }  

  formato_searchDNI() {
    const dniSinGuiones = this.searchCliente.clie_DNI.replace(/-/g, '');
    let grupos = dniSinGuiones.match(/^(\d{4})(\d{4})(\d+)/);
    
    if (grupos) {
      grupos.shift();
      this.searchCliente.clie_DNI = grupos.filter(Boolean).join('-');
    }
  }

  sendSearchDNI(){
    var errors = 0;
    var formatosInvalidos = 0
    const errorsArray: boolean[] = [];
    const formatosInvalidosArray: boolean[] = [];    

    errorsArray[0] = this.validar_searchDNI();
    formatosInvalidosArray[0] = this.FormatoValidoDNIsearch;    

    for (let i = 0; i < errorsArray.length; i++) {      
      if (errorsArray[i] == true) {
        errors++;
      }else{
        errors;
      }
    }

    for (let i = 0; i < formatosInvalidosArray.length; i++) {
      if (formatosInvalidosArray[i] == true) {
        formatosInvalidos++;
      }else{
        formatosInvalidos;
      }
      
    }

    if (errors == 0 && formatosInvalidos == 0) {
      this.fullTicket.clie_Nombres = '';
      this.fullTicket.clie_Apellidos = '';
      this.fullTicket.clie_Sexo = '';
      this.fullTicket.clie_DNI = '';
      this.fullTicket.clie_Telefono = '';
      this.fullTicket.wasSearched = 0      
      this.service.getClienteByDNI(this.searchCliente).subscribe((response : any) =>{
        if (response.success) {
          ToastUtils.showSuccessToast('Cliente encontrado exitosamente!');
          this.clienteData = response.data;
          this.fullTicket.clie_Nombres = this.clienteData.clie_Nombres;
          this.fullTicket.clie_Apellidos = this.clienteData.clie_Apellidos;
          this.fullTicket.clie_Sexo = this.clienteData.clie_Sexo;
          this.fullTicket.clie_DNI = this.clienteData.clie_DNI;
          this.fullTicket.clie_Telefono = this.clienteData.clie_Telefono;
          this.fullTicket.wasSearched = 1

        }else{
          ToastUtils.showErrorToast('Este cliente no existe.');
          this.fullTicket.clie_Nombres = '';
          this.fullTicket.clie_Apellidos = '';
          this.fullTicket.clie_Sexo = '';
          this.fullTicket.clie_DNI = '';
          this.fullTicket.clie_Telefono = '';          
          this.fullTicket.wasSearched = 0
        }
      })
    }
    else if(errors != 0){
      ToastUtils.showWarningToast('Ingresa un DNI');
    }
    else if(errors != 0 && formatosInvalidos != 0){
      
    }
  }
//#endregion

//#region VALIDACIONES INFO DEL CLIENTE 

validarNombres(){
  if (!this.fullTicket.clie_Nombres) {
    this.NombresRequerido = true;
    return true;
  }else{
    this.NombresRequerido = false;
    return false;
  }
}
validarApellidos(){
  if (!this.fullTicket.clie_Apellidos) {
    this.ApellidosRequerido = true;
    return true;
  }else{
    this.ApellidosRequerido = false;
    return false;
  }
}
validarSexo(){
  if (!this.fullTicket.clie_Sexo) {
    this.SexoRequerido = true;
    return true;
  }else{
    this.SexoRequerido = false;
    return false;
  }
}
validarDNI(){
  const dniPattern = /^\d{4}-\d{4}-\d{5}$/;

  if (!this.fullTicket.clie_DNI) {
    this.DNIRequerido = true;
    return true;
  } else if (!dniPattern.test(this.fullTicket.clie_DNI.toString())) {
    this.FormatoValidoDNI = true;
    this.DNIRequerido = true;
    ToastUtils.showWarningToast('Formato de DNI inválido. El formato debe ser XXXX-XXXX-XXXXX');
    return false;
  } else {
    this.DNIRequerido = false;
    this.FormatoValidoDNI = false;
    return false;
  }
}  
validarTelefono(){
  const telefonitoPattern = /^\d{4}-\d{4}$/;

  if(!this.fullTicket.clie_Telefono){
    this.TelefonoRequerido = true;
    return true;
  }else if (!telefonitoPattern.test(this.fullTicket.clie_Telefono.toString())) {
    this.FormatoValidoTelefono = true;
    this.TelefonoRequerido = true;
    ToastUtils.showWarningToast('Formato de Telefono inválido. El formato debe ser XXXX-XXXX');
    return false;
  }
    else{
    this.TelefonoRequerido = false;
    this.FormatoValidoTelefono = false;
    return false;
  }
}  
formatoDNI() {
  const dniSinGuiones = this.fullTicket.clie_DNI.replace(/-/g, '');
  let grupos = dniSinGuiones.match(/^(\d{4})(\d{4})(\d+)/);
  
  if (grupos) {
    grupos.shift();
    this.fullTicket.clie_DNI = grupos.filter(Boolean).join('-');
  }
}
formatoTelefono(){
  const telefonoSinGuines = this.fullTicket.clie_Telefono.replace(/-/g, '');
  let numeritos = telefonoSinGuines.match(/^(\d{4})(\d+)/);

  if(numeritos){
    numeritos.shift();
    this.fullTicket.clie_Telefono = numeritos.filter(Boolean).join('-');
  }
}
//#endregion


sendData(){
  var errors = 0;
  var formatErrors = 0

  const formatErrorsArray: boolean[] = [];
  const errorsArray: boolean[] = [];

  errorsArray[0] = this.validarNombres();
  errorsArray[1] = this.validarApellidos();
  errorsArray[2] = this.validarTelefono();
  errorsArray[3] = this.validarDNI();
  errorsArray[4] = this.validarSexo();

  for (let i = 0; i < errorsArray.length; i++) {
    if (errorsArray[i] == true) {
      errors++;
    }else{
      errors;
    }    
  }

  formatErrorsArray[0] = this.FormatoValidoDNI;
  formatErrorsArray[1] = this.FormatoValidoTelefono;

  for (let i = 0; i < formatErrorsArray.length; i++) {    
    if (formatErrorsArray[i] == true) {
      formatErrors++;
    }else{
      formatErrors;
    }
  }

  if (errors == 0 && formatErrors == 0) {

  }else if (errors != 0) {
    ToastUtils.showWarningToast('Falta información del cliente!');
  }
  else if(errors == 0 && formatErrors != 0){

  }else{

  }
  if (this.selectedClassicTicket == 0 && this.selectedVIPTicket == 0) {
    ToastUtils.showWarningToast('Debes seleccionar almenos un tipo de ticket.');
  }else if((this.selectedClassicTicket == 1 && this.cantidadClasicos == 0) || (this.selectedVIPTicket == 2 && this.cantidadVIP == 0)){
      if((this.selectedClassicTicket == 1 && this.cantidadClasicos == 0)){
        this.cantidadClasicosRequerido = true;
        ToastUtils.showWarningToast('Debes comprar almenos un ticket clásico');
      }
      if ((this.selectedVIPTicket == 2 && this.cantidadVIP == 0)) {
        this.cantidadVIPRequerido = true;
        ToastUtils.showWarningToast('Debes comprar almenos un ticket clásico VIP');
      }
  }else if ((this.selectedClassicTicket == 1 && this.cantidadClasicos < 1) || (this.selectedVIPTicket == 2 && this.cantidadVIP < 1)) {
    ToastUtils.showWarningToast('No se admiten valores menores a uno');   
  }
  else{        
      this.cantidadClasicosRequerido = false;
      this.cantidadVIPRequerido = false;
      var pagoInvalido = this.validarPago();

      

      if(pagoInvalido == true){
        ToastUtils.showWarningToast('Método de pago requerido')
      }else{
        const usua_ID = localStorage.getItem('usua_ID');
        if (usua_ID == null) {
          this.router.navigate(['pages-login']);
        }
        const ticketArray = [];
        const cantidadArray = [];
        ticketArray[0] = this.selectedClassicTicket;
        ticketArray[1] = this.selectedVIPTicket;
        cantidadArray[0] = this.cantidadClasicos;
        cantidadArray[1] = this.cantidadVIP;
        this.fullTicket.ticl_UsuarioCreador = parseInt(usua_ID ?? '')
  
        for (let i = 0; i < ticketArray.length && cantidadArray.length; i++) {          
          
          this.fullTicket.tckt_ID = ticketArray[i];
          this.fullTicket.ticl_Cantidad = cantidadArray[i];

          if (this.fullTicket.tckt_ID == 0 || this.fullTicket.ticl_Cantidad == 0) {
            
          }else{
            this.service.newTicket(this.fullTicket).subscribe((response : any) => {
              if(response.code == 200){
                ToastUtils.showSuccessToast(response.message);
                this.router.navigate(['listticketsclientes']);
              }else if(response.code == 409){
                ToastUtils.showWarningToast(response.message);
              }else{
                ToastUtils.showErrorToast(response.message);

              }
            })            
          }          
        }

      }
  }
}

//#region VALIDAR COMPRA DEL TICKET

  selectClassicTicket(index: number): void {
    if (this.selectedClassicTicket === index) {
      this.selectedClassicTicket = 0; // Deseleccionar el ticket
    } else {
      this.selectedClassicTicket = index; // Almacenar el índice del ticket seleccionado
    }
  }
  
  selectVIPTicket(index: number): void {
    if (this.selectedVIPTicket === index) {
      this.selectedVIPTicket = 0; // Deseleccionar el ticket
    } else {
      this.selectedVIPTicket = index; // Almacenar el índice del ticket seleccionado
    }
  }

  validarPago(){
    if (!this.fullTicket.pago_ID) {
      this.PagoRequerido = true;
      return true;
    }else{
      this.PagoRequerido = false;
      return false;
    }
  };

  clearPagoError(){
    if (this.fullTicket.pago_ID.toString().trim() !== '' || this.fullTicket.pago_ID != 0) {
      this.PagoRequerido = false;
    }
  };

  validarCantidadClasic(){
    if (this.cantidadClasicos <= 0) {
      this.cantidadClasicosRequerido = true;      
    }else{
      this.cantidadClasicosRequerido = false;      
    }
  };

  validarCantidadVIP(){
    if (this.cantidadVIP <= 0) {
      this.cantidadVIPRequerido = true;      
    }else{
      this.cantidadVIPRequerido = false;      
    }    
  }
  Volver(){
    this.router.navigate(['listticketsclientes']);
  }
//#endregion










}
