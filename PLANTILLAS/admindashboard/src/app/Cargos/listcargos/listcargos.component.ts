import { Component, OnInit, ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import { Cargos } from 'src/app/Models/Cargos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listcargos',
  templateUrl: './listcargos.component.html',
  styleUrls: ['./listcargos.component.css']
})
export class ListcargosComponent implements OnInit {
  cargos!: Cargos[];
  dataTable: any;

  constructor(private service:ParqServicesService, private elementRef: ElementRef, private router:Router) { }


  ngOnInit(): void {
    this.service.getCargos().subscribe(data => {
      this.cargos = data;
  
      var s = document.createElement("script");
      s.type = "text/javascript";
      s.src = "../assets/js/main.js";
      this.elementRef.nativeElement.appendChild(s);
    });
  }

  Editar(cargos: Cargos){
    localStorage.setItem('idcargo', cargos.carg_ID.toString());
    console.log(localStorage.getItem('idcargo'));
    this.router.navigate(['editarcargos']);
  }
}  