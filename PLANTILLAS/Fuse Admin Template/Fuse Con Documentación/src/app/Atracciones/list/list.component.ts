import { Component, OnInit } from '@angular/core';
import { Atracciones } from 'app/Model/Atracciones';
import { ParqueServiceService } from 'app/Service/ParqueService/parque-service.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss']
})
export class ListComponent implements OnInit {
  atracciones!: Atracciones[];

  constructor(
    private service: ParqueServiceService, 
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