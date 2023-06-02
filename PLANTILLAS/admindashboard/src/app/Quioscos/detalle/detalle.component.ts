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

  filtro: String = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página


  gridOptions: GridOptions = {};

  GolosinaRequerida = false;
  StockRequerido = false;
  id: any;

  showModalD=false;
  showModalC=false;

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,

  ){};

  ngOnInit(): void {


    this.quiosco = JSON.parse(localStorage.getItem('quiosco') ?? '')     

    this.getInsumos();
    this.getGolosinas();   
    
    this.showModalC = false;
    this.showModalD = false;
 
  }

  filtrarInsumos(): InsumosQuiosco[]{
    const filtroLowerCase = this.filtro.toLowerCase();

    return this.insumos.filter(insumo => {
        const nombreValido = insumo.golo_Nombre.toLowerCase().includes(filtroLowerCase);
        const precioValido = insumo.golo_Precio.toString().toLowerCase().includes(filtroLowerCase);        

        return nombreValido || precioValido
    });    
  }

//#region MODAL CREATE INSUMOS
  openCreateModal() {
    const modalCreate = this.elementRef.nativeElement.querySelector('#modalCreate');
    this.renderer2.setStyle(modalCreate, 'display', 'block');
    setTimeout(() => {
      this.renderer2.addClass(modalCreate, 'show');
      this.showModalC = true;
    }, 0);
  }


  closeCreateModal(){
    const modalCreate = this.elementRef.nativeElement.querySelector('#modalCreate');
    this.renderer2.removeClass(modalCreate, 'show');
    this.clearModal();
    setTimeout(() => {
      this.renderer2.setStyle(modalCreate, 'display', 'none');
      this.showModalC = false;
    }, 300); // Ajusta el tiempo para que coincida con la duración de la transición en CSS
  
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
//#endregion




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
