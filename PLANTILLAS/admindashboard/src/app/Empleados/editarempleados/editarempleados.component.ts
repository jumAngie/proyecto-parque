import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { EstadosCiviles } from 'src/app/Models/EstadosCiviles';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Cargos } from 'src/app/Models/Cargos';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { Router } from '@angular/router';

@Component({
  selector: 'app-editarempleados',
  templateUrl: './editarempleados.component.html',
  styleUrls: ['./editarempleados.component.scss']
})
export class EditarempleadosComponent {
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

  constructor(private service:ParqServicesService, private elementRef: ElementRef, private router:Router) { }

  ngOnInit(): void {
    this.CargarDatos();
  }

  CargarDatos(){
    // DDL ESTADO CIVIL
    this.service.getEstadoCivil()
    .subscribe(data => {
      this.estadosciviles = data;
    });

    // DDL CARGOS
    this.service.getCargos().subscribe(data => {
      this.cargos = data;
  });

    // CARGAR LOS DATOS AL FORMULARIO
    const idEmpleado: number | undefined = isNaN(parseInt(localStorage.getItem("idEmpleado") ?? '', 10)) ? undefined: parseInt(localStorage.getItem("idEmpleado") ?? '', 10)
    this.service.getEmpleadosId(idEmpleado)
    .subscribe((data)=>{
      this.empleados = data;
      console.log(data);
    })
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
      this.empleados.empl_UsuarioCreador = 1;
      this.service.insertEmpleados(this.empleados)
      .subscribe((response: any) =>{
        console.log(response)
        if(response.code == 200){
          ToastUtils.showSuccessToast(response.messageStatus);          
          this.router.navigate(['listempleados']);
        }else{
          ToastUtils.showErrorToast(response.messageStatus);
        }
      })
    }
    else{
      ToastUtils.showWarningToast('Campos vacíos. Llene todos los campos obligatorios.')
    }
  }

  validarPrimerNombre() {
    if(!this.empleados.empl_PrimerNombre){
      this.PrimerNombreRequerido = true;
      return true;
    }else{
      this.PrimerNombreRequerido = false;
      return false;
    }
  }

  validarPrimerApellido(){
    if(!this.empleados.empl_PrimerApellido){
      this.PrimerApellidoRequerido = true;
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
      return true;
    } else if (!dniPattern.test(this.empleados.empl_DNI)) {
      this.DNIRequerido = false;
      ToastUtils.showWarningToast('Formato de DNI inválido. El formato debe ser XXXX-XXXX-XXXXX');
      return true;
    } else {
      this.DNIRequerido = false;
      return false;
    }
  }

 validarEmail() {
  const emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

  if (!this.empleados.empl_Email) {
    this.EmailRequerido = true;
    return true;
  } else if (!emailPattern.test(this.empleados.empl_Email)) {
    this.EmailRequerido = false;
    ToastUtils.showWarningToast('Correo Electrónico inválido. Por favor, ingrese un correo válido.');
    return true;
  } else {
    this.EmailRequerido = false;
    return false;
  }
}


  validarSexo(){
    if(!this.empleados.empl_Sexo){
      this.SexoRequerido = true;
      return true;
    }else{
      this.SexoRequerido = false;
      return false;
    }
  }

  validarTelefono(){

    const telefonitoPattern = /^\d{4}-\d{4}$/;

    if(!this.empleados.empl_Telefono){
      this.TelefonoRequerido = true;
      return true;
    }else if (!telefonitoPattern.test(this.empleados.empl_Telefono)) {
      this.TelefonoRequerido = false;
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
      return true;
    }else{
      this.CargoRequerido = false;
      return false;
    }
  }

  validarEstadoCivil(){
    if(!this.empleados.civi_ID){
      this.EstCivilRequerido = true;
      return true;
    }else{
      this.EstCivilRequerido = false;
      return false;
    }
  }
 

  // formateos
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

  Volver(){
    this.router.navigate(['listempleados']);
  }

}
