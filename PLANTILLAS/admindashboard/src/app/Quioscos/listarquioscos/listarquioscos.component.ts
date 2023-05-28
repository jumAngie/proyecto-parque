import { Component, OnInit, ViewChild, ElementRef, Renderer2 } from '@angular/core';
import { Quioscos } from 'src/app/Models/Quioscos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { GridOptions, GridApi, ColumnApi } from 'ag-grid-community';
import { QuioscoActionsRenderer } from './QuioscoActionsRenderer.component';
import { DetalleRendererComponent } from './DetalleRendererComponent.component';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-listarquioscos',
  templateUrl: './listarquioscos.component.html',
  styleUrls: ['./listarquioscos.component.css']
})

export class ListarquioscosComponent implements OnInit{
  quioscos!: Quioscos[];
  gridOptions: GridOptions = {};
  deleteID: any;

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,
  ){};

  ngOnInit(): void{
    this.gridOptions = {
      columnDefs: [
        {headerName: 'ID', field: 'quio_ID', width: 75, autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Quiosco', field: 'quio_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Dirección', field: 'quio_ReferenciaUbicacion', width: 300, autoHeight: true, autoHeaderHeight: true},
        {
          headerName: 'Acciones',
          width: 350, 
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
      paginationPageSize: 7,            
      defaultColDef: {
        sortable: true,
        filter: true,
        resizable: true,
        unSortIcon: true,
        wrapHeaderText: true,
        wrapText: true,
      },
      frameworkComponents: {
        actionsRenderer: QuioscoActionsRenderer,
      },
      localeText: {
        // Encabezados de columna
        columnMenuName: 'Menú de columnas',
        columnHide: 'Ocultar',
        columnShowAll: 'Mostrar todo',
        columnDefs: 'Definiciones de columnas',
        // Otros textos
        loadingOoo: 'Cargando...',
        noRowsToShow: 'No hay filas para mostrar',
        page: 'Página',
        more: 'Más',
        to: 'a',
        of: 'de',
        next: 'Siguiente',
        last: 'Último',
        first: 'Primero',
        previous: 'Anterior', 
      },
    }

    this.getQuioscos();
  };
 
  getQuioscos(){
    this.service.getQuioscos().subscribe((response: any) =>{
      if(response.success){
        this.quioscos = response.data;
        this.gridOptions.api?.setRowData(this.quioscos);
      }
    });
  };
  
  Agregar(){
    this.router.navigate(['quioscos-crear']);
  }

  onDetail(rowData: any): void{    
    localStorage.setItem('quiosco', JSON.stringify(rowData));    
    this.router.navigate(['quioscos-detalle']);
  }
  
  onEdit(rowData: any): void {
    localStorage.setItem('quio_ID', rowData.quio_ID);
            
    this.router.navigate(['quioscos-editar']);         
  }
  
  onDelete(rowData: any): void {
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.addClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'block');
    this.deleteID = rowData.quio_ID;
  }

  closeModal(): void {
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.removeClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'none');
    
  }

  confirmDelete(){
    this.service.deleteQuiosco(this.deleteID).subscribe((response : any) =>{
      if(response.code == 200){
        ToastUtils.showSuccessToast(response.message);
        this.getQuioscos();
      }else if(response.code == 409){
        ToastUtils.showWarningToast(response.message);
      }else{
        ToastUtils.showErrorToast(response.message);
      }
    })
    this.closeModal();
  }

};
