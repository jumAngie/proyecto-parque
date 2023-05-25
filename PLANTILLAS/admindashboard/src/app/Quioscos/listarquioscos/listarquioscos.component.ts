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
        {headerName: 'ID', field: 'quio_ID'},
        {headerName: 'Quiosco', field: 'quio_Nombre'},
        {
          headerName: 'Acciones',
          cellRenderer: 'actionsRenderer',
          cellRendererParams: {
            onDetail: this.onDetail.bind(this),
            onEdit: this.onEdit.bind(this),
            onDelete: this.onDelete.bind(this),
          }
        }
      ],
      rowData: this.quioscos,
      pagination: true,
      paginationPageSize: this.pageSize,
      paginationAutoPageSize: true,
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

  }

  onEdit(rowData: any): void {
    // Lógica para editar el registro
  }
  
  onDelete(rowData: any): void {
    // Lógica para eliminar el registro
  }
};
