import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListVentasQuioscoDetalleComponent implements OnInit {
  ventasQuioscoDetalle!: VentasQuioscoDetalle[];

  constructor(
    private service: ParqServicesService, 
    private router: Router
  ) { }

  ngOnInit(): void {
    this.service.getVentasQuioscoDetalle()
    .subscribe((response: any) => {
      if(response.success){
        this.ventasQuioscoDetalle = response.data;
        console.log(response.data);
      }
    })
  }

}
