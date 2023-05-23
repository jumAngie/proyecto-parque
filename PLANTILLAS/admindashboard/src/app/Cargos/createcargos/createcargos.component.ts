import { Component, ElementRef} from '@angular/core';
import { Router } from '@angular/router';
import { Cargos } from 'src/app/Models/Cargos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

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
  constructor(private service:ParqServicesService, private elementRef: ElementRef, private router:Router) { }

  Guardar(){
    this.service.createCargos(this.cargos)
    .subscribe((response: any)=>{
      if (response.code == 200 && response.data.codeStatus == 200)
      {
        this.showSuccessAlert = true;
        this.successMessage = response.data.messageStatus;
        this.router.navigate(["listcargos"])
      }
      else
      {
        this.showErrorAlert = true;
        this.errorMessage = "Ha ocurrido un error. Vuelva a ingresar los datos";
      }
      
    })
  }

  closeErrorAlert() {
    this.showErrorAlert = false;
  }

  closeSuccessAlert() {
    this.showSuccessAlert = false;
  }

}
