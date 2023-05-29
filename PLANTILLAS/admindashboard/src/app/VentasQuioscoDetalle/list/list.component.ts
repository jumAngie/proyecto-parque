import { Component, OnInit, ElementRef, Renderer2 } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { GridOptions, GridApi, ColumnApi } from 'ag-grid-community';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';


@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})

export class VentasListComponent implements OnInit {
  ventasQuioscoDetalle!: VentasQuioscoDetalle[];
  deleteID: any;
  gridOptions: GridOptions = {};


  constructor(
    private service: ParqServicesService, 
    private router: Router
  ) { }

  ngOnInit(): void {

    this.getVentas();
  }

  getVentas(){
    this.service.getVentas()
    .subscribe((response: any) => {
      if(response.success){
        this.ventasQuioscoDetalle = response.data;
        console.log(response.data);
      }
    })
  }


  Agregar(){
    this.router.navigate(['ventasquiosco-crear']);
  };


}
