import { Component, OnInit } from '@angular/core';
import { InsumosQuiosco } from 'src/app/Models/InsumosQuiosco';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { GridOptions, GridApi, ColumnApi } from 'ag-grid-community';
import { QuioscoActionsRenderer } from '../listarquioscos/QuioscoActionsRenderer.component';
import { Quioscos } from 'src/app/Models/Quioscos';

@Component({
  selector: 'app-detalle',
  templateUrl: './detalle.component.html',
  styleUrls: ['./detalle.component.css']
})
export class DetalleQuioscoComponent implements OnInit{
  insumos!: InsumosQuiosco[];  
  quiosco: Quioscos = new Quioscos();

  gridOptions: GridOptions = {};
  searchText: any;
  pageSize: any;
  pageIndex: any;
  totalRecords: any;
  
  id: any;
  constructor(
    private service: ParqServicesService,
    private router: Router,
  ){};

  ngOnInit(): void {
    this.gridOptions = {
      columnDefs: [
        {headerName: 'ID', field: 'golo_ID', width: 75, autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Golosina', field: 'golo_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Stock', field: 'insu_Stock',  autoHeight: true, autoHeaderHeight: true},

      ],
      rowData: this.insumos,
      pagination: true,
      defaultColDef: {
        sortable: true,
        filter: true,
        resizable: true,
        unSortIcon: true,
        wrapHeaderText: true,
        checkboxSelection: true,
        headerCheckboxSelection: true,
        editable: true,
        cellEditorPopup: true,

      }
    };

    this.quiosco = JSON.parse(localStorage.getItem('quiosco') ?? '')     

    this.getInsumos();
  }


  getInsumos(){    
    this.service.getInsumos(this.quiosco.quio_ID).subscribe((response: any) =>{
      if(response.success){
        this.insumos = response.data;
        this.gridOptions.api?.setRowData(this.insumos);
      };      
    });
  };

  Volver(){
    this.router.navigate(['quioscos-listado']);
  }
}
