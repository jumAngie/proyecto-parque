import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listempleados',
  templateUrl: './listempleados.component.html',
  styleUrls: ['./listempleados.component.scss']
})
export class ListempleadosComponent implements OnInit {
  empleados!: Empleados[];
  filtro: string = '';
  p: number = 1;

  constructor(private service:ParqServicesService, private elementRef: ElementRef) { }

  ngOnInit(): void {
    this.service.getEmpleados()
      .subscribe(data => {
        this.empleados = data;
  
        var s = document.createElement("script");
        s.type = "text/javascript";
        s.src = "../assets/js/main.js";
        this.elementRef.nativeElement.appendChild(s);
      });
  }

  filtrarEmpleados(): Empleados[] {
    const filtroLowerCase = this.filtro.toLowerCase();
  
    return this.empleados.filter(empleado => {
      const nombreValido = empleado.empl_NombreCompleto.toLowerCase().includes(filtroLowerCase);
      const estadoCivilValido = empleado.civi_Descripcion.toLowerCase().includes(filtroLowerCase);
      const dniValido = empleado.empl_DNI.toString().includes(this.filtro);
      const telefonoValido = empleado.empl_Telefono.toString().includes(this.filtro);
  
      return nombreValido || estadoCivilValido || dniValido || telefonoValido;
    });
  }
  
  
  
}  
