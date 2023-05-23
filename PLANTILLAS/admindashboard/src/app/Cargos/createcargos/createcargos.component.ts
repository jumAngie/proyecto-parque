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
  
  showSuccessToast(message: string) {
    SuccessToast(message);
  }
  
  showErrorToast(message: string) {
    ErrorToast(message);
  }
  
  showInfoToast(message: string) {
    InfoToast(message);
  }
  
  showWarningToast(message: string) {
    WarningToast(message);
  }
  
}