import { Component, OnInit } from '@angular/core';
import { Cargos } from 'src/app/Models/Cargos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listcargos',
  templateUrl: './listcargos.component.html',
  styleUrls: ['./listcargos.component.css']
})
export class ListcargosComponent implements OnInit {
  cargos!: Cargos[];

  constructor(private service:ParqServicesService) { }

  ngOnInit(): void {
    this.service.getCargos()
    .subscribe(data=>{
      this.cargos = data;
    })
  }

}
