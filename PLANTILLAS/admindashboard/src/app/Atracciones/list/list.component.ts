import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListAtraccionesComponent implements OnInit {
  atracciones!: Atracciones[];

  constructor(
    private service: ParqServicesService, 
    private router: Router
  )
  { };

  ngOnInit(): void {
    this.service.getAtracciones()
    .subscribe((response: any) => {
      if(response.success){
        this.atracciones = response.data;
        console.log(response.data);
      }
    })
  }

};

/*
ngOnInit(): void {
    this.service.getCategoria()
    .subscribe((response: any) => {
      if (response.success) {
        this.categoria = response.data;
        console.log(response.data);
      }
    });
*/
