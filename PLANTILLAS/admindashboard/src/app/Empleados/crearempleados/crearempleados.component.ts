import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { EstadosCiviles } from 'src/app/Models/EstadosCiviles';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Cargos } from 'src/app/Models/Cargos';

@Component({
  selector: 'app-crearempleados',
  templateUrl: './crearempleados.component.html',
  styleUrls: ['./crearempleados.component.scss'],
})
export class CrearempleadosComponent implements OnInit {
  empleados: Empleados = new Empleados();
  cargos!: Cargos[];
  estadosciviles!: EstadosCiviles[];

  constructor(
    private service: ParqServicesService,
    private elementRef: ElementRef
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

  campoVacio(): boolean {
    const campos = [
      this.empleados.empl_PrimerNombre,
      this.empleados.empl_SegundoNombre,
      this.empleados.empl_PrimerApellido,
      this.empleados.empl_SegundoApellido,
      this.empleados.empl_DNI,
      this.empleados.empl_Email,
      this.empleados.empl_Telefono,
      this.empleados.civi_ID,
      this.empleados.carg_ID,
      this.empleados.empl_Sexo
    ];
  
    return campos.some((campo) => !campo);
  }

  guardarEmpleado(){
    if (this.campoVacio()) {
     console.log('holiiiiiiiii');
      
    } else {
      console.log('wiwiwiwiwi');
    }
  }
  
  
}
