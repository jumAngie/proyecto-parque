import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { EstadosCiviles } from 'src/app/Models/EstadosCiviles';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Cargos } from 'src/app/Models/Cargos';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { Router } from '@angular/router';

@Component({
  selector: 'app-crearempleados',
  templateUrl: './crearempleados.component.html',
  styleUrls: ['./crearempleados.component.scss'],
})
export class CrearempleadosComponent implements OnInit {
  empleados: Empleados = new Empleados();
  cargos!: Cargos[];
  estadosciviles!: EstadosCiviles[];

  // VALIDACIÓN DE CAMPOS 1x1
  PrimerNombreRequerido = false;
  PrimerApellidoRequerido = false;
  DNIRequerido = false;
  EmailRequerido = false;
  TelefonoRequerido = false;
  SexoRequerido = false;
  EstCivilRequerido = false;
  CargoRequerido = false;

  constructor(
    private service: ParqServicesService,
    private elementRef: ElementRef,
    private router: Router
  ) {}

  ngOnInit(): void {

      this.service.getEstadoCivil()
      .subscribe(data => {
        this.estadosciviles = data;
      });

      this.service.getCargos().subscribe(data => {
        this.cargos = data;
    });
  }

  guardarEmpleado(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    errorsArray[0] = this.validarPrimerNombre();
    errorsArray[1] = this.validarPrimerApellido();
    errorsArray[2] = this.validarDNI();
    errorsArray[3] = this.validarEmail();
    errorsArray[4] = this.validarTelefono();
    errorsArray[5] = this.validarCargo();
    errorsArray[6] = this.validarEstadoCivil();
    errorsArray[7] = this.validarSexo();

    for (let i = 0; i < errorsArray.length; i++) {
      if(errorsArray[i] == true){
        errors++;
      }
      else{
        errors;
      }  
    }

    if(errors == 0){
      this.service.insertEmpleados(this.empleados)
      .subscribe((response: any) =>{
        console.log(response)
        if(response.success){
          ToastUtils.showSuccessToast(response.data.messageStatus);          
          this.router.navigate(['listempleados']);
        }else{
          ToastUtils.showErrorToast(response.data.messageStatus);
        }
      })
    }
  }

  validarPrimerNombre() {
    if(!this.empleados.empl_PrimerNombre){
      this.PrimerNombreRequerido = true;
      ToastUtils.showWarningToast('Campo "Primer Nombre" requerido');
      return true;
    }else{
      this.PrimerNombreRequerido = false;
      return false;
    }
  }

  validarPrimerApellido(){
    if(!this.empleados.empl_PrimerApellido){
      this.PrimerApellidoRequerido = true;
      ToastUtils.showWarningToast('Campo "Primer Apellido" requerido.');
      return true;
    }else{
      this.PrimerApellidoRequerido = false;
      return false;
    }
  }

  validarDNI() {
    const dniPattern = /^\d{4}-\d{4}-\d{5}$/;

    if (!this.empleados.empl_DNI) {
      this.DNIRequerido = true;
      ToastUtils.showWarningToast('Campo "DNI" requerido.');
      return false;
    } else if (!dniPattern.test(this.empleados.empl_DNI)) {
      this.DNIRequerido = false;
      ToastUtils.showWarningToast('Formato de DNI inválido. El formato debe ser XXXX-XXXX-XXXXX');
      return false;
    } else {
      this.DNIRequerido = false;
      return true;
    }
  }

  formatoDNI() {
    const dniSinGuiones = this.empleados.empl_DNI.replace(/-/g, '');
    let grupos = dniSinGuiones.match(/^(\d{4})(\d{4})(\d+)/);
    
    if (grupos) {
      grupos.shift();
      this.empleados.empl_DNI = grupos.filter(Boolean).join('-');
    }
  }
  
  
  formatoTelefono(){
    const telefonoSinGuines = this.empleados.empl_Telefono.replace(/-/g, '');
    let numeritos = telefonoSinGuines.match(/^(\d{4})(\d{4})/);

    if(numeritos){
      numeritos.shift();
      this.empleados.empl_Telefono = numeritos.filter(Boolean).join('-');
    }
  }

 validarEmail() {
  const emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

  if (!this.empleados.empl_Email) {
    this.EmailRequerido = true;
    ToastUtils.showWarningToast('Campo "Correo Electrónico" requerido.');
    return false;
  } else if (!emailPattern.test(this.empleados.empl_Email)) {
    this.EmailRequerido = false;
    ToastUtils.showWarningToast('Correo Electrónico inválido. Por favor, ingrese un correo válido.');
    return false;
  } else {
    this.EmailRequerido = false;
    return true;
  }
}


  validarSexo(){
    if(!this.empleados.empl_Sexo){
      this.SexoRequerido = true;
      ToastUtils.showWarningToast('Campo "Sexo" requerido.');
      return true;
    }else{
      this.SexoRequerido = false;
      return false;
    }
  }

  validarTelefono(){

    const telefonitoPattern = /^(\d{4})(\d{4})/;

    if(!this.empleados.empl_Telefono){
      this.TelefonoRequerido = true;
      ToastUtils.showWarningToast('Campo "Telefono" requerido.');
      return true;
    }else if (!telefonitoPattern.test(this.empleados.empl_Telefono)) {
      this.DNIRequerido = false;
      ToastUtils.showWarningToast('Formato de Telefono inválido. El formato debe ser XXXX-XXXX');
      return false;
    }
      else{
      this.TelefonoRequerido = false;
      return false;
    }
  }

  validarCargo(){
    if(!this.empleados.carg_ID){
      this.CargoRequerido = true;
      ToastUtils.showWarningToast('Campo "Cargo" requerido.');
      return true;
    }else{
      this.CargoRequerido = false;
      return false;
    }
  }

  validarEstadoCivil(){
    if(!this.empleados.civi_ID){
      this.EstCivilRequerido = true;
      ToastUtils.showWarningToast('Campo "Estado Civil" requerido.');
      return true;
    }else{
      this.EstCivilRequerido = false;
      return false;
    }
  }
 
  
}
