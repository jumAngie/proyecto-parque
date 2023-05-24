import { Component, OnInit, ElementRef } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listempleados',
  templateUrl: './listempleados.component.html',
  styleUrls: ['./listempleados.component.css']
})
export class ListempleadosComponent implements OnInit {
  empleados!: Empleados[];

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
}  