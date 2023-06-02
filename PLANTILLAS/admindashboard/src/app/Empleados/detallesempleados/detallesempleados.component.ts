import { Component } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Empleados } from 'src/app/Models/Empleados';

@Component({
  selector: 'app-detallesempleados',
  templateUrl: './detallesempleados.component.html',
  styleUrls: ['./detallesempleados.component.css']
})
export class DetallesempleadosComponent {
  empleados: Empleados = new Empleados();
  requestData: Empleados = new Empleados();

  constructor(
    private service: ParqServicesService,
    private router: Router,

  ){}

  ngOnInit(): void {
    this.getEmpleadosDetails();
  }


  getEmpleadosDetails(){
    this.requestData.empl_ID = parseInt(localStorage.getItem('empleado_Detail_Id')?.toString() ?? '')
    this.service.getEmpleadosId(this.requestData.empl_ID).subscribe((response : any) =>{
      console.log(response);
        this.empleados = response;
        console.log(this.empleados);
    })
  };

  Volver(){
    this.router.navigate(['listempleados']);
  }
}
