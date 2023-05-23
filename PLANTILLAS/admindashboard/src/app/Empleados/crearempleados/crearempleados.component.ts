import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { EstadosCiviles } from 'src/app/Models/EstadosCiviles';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-crearempleados',
  templateUrl: './crearempleados.component.html',
  styleUrls: ['./crearempleados.component.scss']
})
export class CrearempleadosComponent implements OnInit {

  empleados!: Empleados[];
  estadosciviles!: EstadosCiviles[];

  constructor(private service:ParqServicesService, private elementRef: ElementRef) { }

  ngOnInit(): void {
  }

}
