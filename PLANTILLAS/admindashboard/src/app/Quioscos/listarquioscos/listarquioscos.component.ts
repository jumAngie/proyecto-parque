import { Component, OnInit } from '@angular/core';
import { Quioscos } from 'src/app/Models/Quioscos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { GridOptions, GridApi, ColumnApi } from 'ag-grid-community';
import { QuioscoActionsRenderer } from './QuioscoActionsRenderer.component';

@Component({
  selector: 'app-listarquioscos',
  templateUrl: './listarquioscos.component.html',
  styleUrls: ['./listarquioscos.component.css']
})

export class ListarquioscosComponent implements OnInit{
  quioscos!: Quioscos[];
  gridOptions: GridOptions = {};
  searchText: any;
  pageSize: any;
  pageIndex: any;
  totalRecords: any;


  constructor(
    private service: ParqServicesService,
    private router: Router,
  ){};

  ngOnInit(): void{
    this.gridOptions = {
      columnDefs: [
        {headerName: 'ID', field: 'quio_ID', width: 75, autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Quiosco', field: 'quio_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Dirección', field: 'quio_ReferenciaUbicacion', width: 300, autoHeight: true, autoHeaderHeight: true},
        {
          headerName: 'Acciones',
          width: 290, 
          sortable: false,
          filter: false,
          cellRenderer: 'actionsRenderer',
          cellRendererParams: {
            onDetail: this.onDetail.bind(this),
            onEdit: this.onEdit.bind(this),
            onDelete: this.onDelete.bind(this),
          }
        },
      ],
      rowData: this.quioscos,
      pagination: true,
      paginationPageSize: this.pageSize,
      quickFilterText: this.searchText,
      onGridReady: () =>{
        
      },
      defaultColDef: {
        sortable: true,
        filter: true,
      },
      frameworkComponents: {
        actionsRenderer: QuioscoActionsRenderer
      }
    }

    this.getQuioscos();
  };


  
  getQuioscos(){
    this.service.getQuioscos().subscribe((response: any) =>{
      console.log(response)
      if(response.success){
        this.quioscos = response.data;
        this.gridOptions.api?.setRowData(this.quioscos);
      }
    });
  };

  onDetail(rowData: any): void{    
    localStorage.setItem('quiosco', JSON.stringify(rowData));    
    this.router.navigate(['quioscos-detalle']);
  }

  onEdit(rowData: any): void {
    localStorage.setItem('quio_ID', rowData.quio_ID);
            
    this.router.navigate(['quioscos-editar']);         
  }
  
  onDelete(rowData: any): void {
    // Lógica para eliminar el registro
  }

  Agregar(){
    this.router.navigate(['quioscos-crear']);
  }

};
