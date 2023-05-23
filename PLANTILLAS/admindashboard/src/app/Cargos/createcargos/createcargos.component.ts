import { Component, ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import { Cargos } from 'src/app/Models/Cargos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
declare const SuccessToast: any;
declare const ErrorToast: any;
declare const InfoToast: any;
declare const WarningToast: any;

@Component({
  selector: 'app-createcargos',
  templateUrl: './createcargos.component.html',
  styleUrls: ['./createcargos.component.css']
})
export class CreatecargosComponent {
  
  cargos: Cargos = new Cargos();
  showErrorAlert = false;
  showSuccessAlert = false;
  errorMessage = '';
  successMessage = '';
  showToast = false;
  toastMessage = '';

  constructor(private service: ParqServicesService, private elementRef: ElementRef, private router: Router) { }

  Guardar() {
   
    if (this.cargos.carg_UsuarioCreador == 0 || this.cargos.carg_Nombre == null){
      this.showErrorToast('Ambos campos son obligatorios.');
    }
    else
    {
      this.service.createCargos(this.cargos)
      .subscribe((response: any) => {
        if (response.code == 200 && response.data.codeStatus == 200) {
          this.showSuccessToast(response.data.messageStatus);
          this.router.navigate(["listcargos"]);
        } 
        else if (response.data.codeStatus == 409) {
          this.showErrorToast(response.data.messageStatus);
        }
        else {
          this.showErrorToast(response.data.messageStatus);
        }
      });
    }
    
  }
  
  showToastMessage(type: string, message: string) {
    this.showToast = true;
    this.toastMessage = message;

    setTimeout(() => {
      this.showToast = false;
      this.toastMessage = '';
    }, 1000);
  }

  closeSuccessAlert() {
    this.showSuccessAlert = false;
  }

  showSuccessToast(message: string) {
    SuccessToast(message);
    setTimeout(() => {
      this.showSuccessToast = close;
    }, 1500);
  }
  
  showErrorToast(message: string) {
    ErrorToast(message);
    setTimeout(() => {
      this.showErrorToast = close;
    }, 1500);
  }
  
  showInfoToast(message: string) {
    InfoToast(message);
    setTimeout(() => {
      this.showInfoToast = close;
    }, 1500);
  }
  
  showWarningToast(message: string) {
    WarningToast(message);
    setTimeout(() => {
      this.showWarningToast = close;
    }, 1500);
  }
  
}