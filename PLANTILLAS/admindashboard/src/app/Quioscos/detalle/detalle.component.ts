import { Component, OnInit, ViewChild, ElementRef, Renderer2 } from '@angular/core';
import { InsumosQuiosco } from 'src/app/Models/InsumosQuiosco';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { GridOptions, GridApi, ColumnApi, SortIndicatorComp } from 'ag-grid-community';
import { Quioscos } from 'src/app/Models/Quioscos';
import { Golosinas } from 'src/app/Models/Golosinas';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({

  selector: 'app-detalle',
  templateUrl: './detalle.component.html',
  styleUrls: ['./detalle.component.css'],
})

export class DetalleQuioscoComponent implements OnInit{
  quiosco: Quioscos = new Quioscos();
  insumos!: InsumosQuiosco[];  
  golosinas!: Golosinas[];
  sendInsumos: InsumosQuiosco = new InsumosQuiosco();

  gridOptions: GridOptions = {};

  GolosinaRequerida = false;
  StockRequerido = false;
  id: any;


  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,

  ){};

  ngOnInit(): void {
    this.gridOptions = {
      columnDefs: [
        {headerName: 'ID', field: 'golo_ID', width: 150, autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Golosina', field: 'golo_Nombre', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Precio unitario', field: 'golo_Precio', autoHeight: true, autoHeaderHeight: true},
        {headerName: 'Stock', field: 'insu_Stock',  autoHeight: true, autoHeaderHeight: true},
      ],
      rowData: this.insumos,
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
    };

    this.quiosco = JSON.parse(localStorage.getItem('quiosco') ?? '')     

    this.getInsumos();
    this.getGolosinas();    
 
    // const myElementRef = this.elementRef.nativeElement.querySelector('#myElement');
    // console.log(myElementRef);

    // const myElementRendered = this.renderer2.selectRootElement('#myElement');
    // console.log(myElementRendered);
  }

  openModal(): void {
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.addClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'block');
  }

  closeModal(): void {
    const modalElement = this.elementRef.nativeElement.querySelector('.modal');
    this.renderer2.removeClass(modalElement, 'show');
    this.renderer2.setStyle(modalElement, 'display', 'none');
    
    this.clearModal();
  }


  clearModal(): void{
    const selectElement = this.elementRef.nativeElement.querySelector('#golo_ID');
    this.renderer2.setProperty(selectElement, 'value', '');

    const inputElement = this.elementRef.nativeElement.querySelector('#insu_Stock');
    this.renderer2.setProperty(inputElement, 'value', '');

    this.sendInsumos.quio_ID = 0;
    this.sendInsumos.golo_ID = 0;
    this.sendInsumos.insu_Stock = null;
    this.StockRequerido = false;
    this.GolosinaRequerida = false;
  }

  getGolosinas(){
    this.service.getGolosinas().subscribe((response: any) =>{
      if(response.success){
        this.golosinas = response.data;
      }
    })
  }

  getInsumos(){    
    this.service.getInsumosByQuisco(this.quiosco.quio_ID).subscribe((response: any) =>{
      if(response.success){
        this.insumos = response.data;
        this.gridOptions.api?.setRowData(this.insumos);
      };      
    });
  };

  Volver(){
    this.router.navigate(['quioscos-listado']);
  }

  Guardar(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    errorsArray[0] = this.validarGolosina();
    errorsArray[1] = this.validarStock();

    for (let i = 0; i < errorsArray.length; i++) {
      if (errorsArray[i] == true) {
        errors ++;
      }else{
        errors;
      }
    }

    if (errors == 0) {
      this.sendInsumos.insu_UsuarioCreador = 1;
      this.sendInsumos.quio_ID = this.quiosco.quio_ID
      this.service.sendInsumos(this.sendInsumos).subscribe((response : any) =>{
        if (response.code == 200) {
          ToastUtils.showSuccessToast(response.message);
          this.getInsumos();
          this.clearModal();          
        }else if(response.code == 409){
          ToastUtils.showWarningToast(response.message);
        }else{
          ToastUtils.showErrorToast(response.message);
        }
      })
    } else {
      ToastUtils.showWarningToast('Hay campos vacios!');
    }
  };

  validarGolosina(){
    if(!this.sendInsumos.golo_ID){
      this.GolosinaRequerida = true;
      return true;
    }else{
      this.GolosinaRequerida = false;
      return false;
    }
  };

  validarStock(){
    if(!this.sendInsumos.insu_Stock){
      this.StockRequerido = true;
      return true;
    }else{
      this.StockRequerido = false;
      return false;
    }
  };

  clearGolosinaError(){
    if(this.sendInsumos.golo_ID.toString() != '' || this.sendInsumos.golo_ID != 0){
      this.GolosinaRequerida = false;
    }
  }

  clearStockError() {
    if (
      this.sendInsumos.insu_Stock >= 1 &&
      this.sendInsumos.insu_Stock <= 99 &&
      !this.sendInsumos.insu_Stock.includes('-') &&
      !this.sendInsumos.insu_Stock.includes(' ') &&
      !/[a-zA-Z]/.test(this.sendInsumos.insu_Stock)
    ) {
      this.StockRequerido = false;
    } else {
      this.StockRequerido = true; 

    }
  }
  
  
}
