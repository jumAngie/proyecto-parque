import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { ClientesRegistrados } from 'src/app/Models/ClientesRegistrados';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListClientesRegistradosComponent implements OnInit {
  clientesRegistrados!: ClientesRegistrados[];

  constructor(
    private service: ParqServicesService,
    private router: Router,
  ) { };

  ngOnInit(): void {
    this.service.getClientesRegistrados()
    .subscribe((response: any) => {
      if(response.success){
        this.clientesRegistrados = response.data;
        console.log(response.data);
      }
    })
  }

}
