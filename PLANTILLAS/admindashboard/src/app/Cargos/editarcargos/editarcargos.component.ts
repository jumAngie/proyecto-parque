import { Component, OnInit, ElementRef } from '@angular/core';
import { Cargos } from 'src/app/Models/Cargos';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-editarcargos',
  templateUrl: './editarcargos.component.html',
  styleUrls: ['./editarcargos.component.css']
})

  
export class EditarcargosComponent implements OnInit {

  cargos: Cargos = new Cargos();
  showErrorAlert = false;
  showSuccessAlert = false;
  errorMessage = '';
  successMessage = '';
  constructor(private service:ParqServicesService, private elementRef: ElementRef, private router:Router) { }


  ngOnInit(): void {
    this.Editar();
  }

  Editar(){
    const idcargo: number | undefined = isNaN(parseInt(localStorage.getItem("idcargo") ?? '', 10)) ? undefined: parseInt(localStorage.getItem("idcargo") ?? '', 10)
    this.service.getCargosId(idcargo)
    .subscribe((data)=>{
      this.cargos = data;
    })
  }

  closeErrorAlert() {
    this.showErrorAlert = false;
  }

  closeSuccessAlert() {
    this.showSuccessAlert = false;
  }


}
