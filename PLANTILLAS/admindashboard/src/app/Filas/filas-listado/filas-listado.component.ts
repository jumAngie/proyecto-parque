import { Component, ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import { Filas } from 'src/app/Models/Filas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { NgModel } from '@angular/forms';
import { data } from 'jquery';
import { Atracciones } from 'src/app/Models/Atracciones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
@Component({
  selector: 'app-filas-listado',
  templateUrl: './filas-listado.component.html',
  styleUrls: ['./filas-listado.component.css'],
  providers: [NgModel] 
})
export class FilasListadoComponent {

  constructor(
    private router: Router,
    private elementRef: ElementRef,
    private PService: ParqServicesService,
  ) {}

  fila: Filas[] = [];
  filasfiltradas: Filas[] = [];
  ddlAtracciones: Atracciones[] = [];
  tifi_ID = 0;
  atra_ID = 0;
  atra_ID2= 0;
  ticl_ID = "";
  fiat_ID = 0;
  fipo_ID = 0;
  p: number = 1;
  filtro: string = '';
  itemsPerPage = 10;
  paginacionConfig: any = {
    itemsPerPage: 10,
    currentPage: 1,
    totalItems: 0
  };

  AtraccionRe=false;
  TicketRe=false;


  ngOnInit(): void {

    this.PService.getAtracciones()
    .subscribe((response: any) => {
      if (response.success) {
        this.ddlAtracciones = response.data;
      }
    });
  }
  
  FilasPosiciones():void{
    if (this.atra_ID == 0 ) { 
      ToastUtils.showWarningToast("Atracción no Seleccionada");
    }

    if (this.tifi_ID==0) {
      ToastUtils.showWarningToast("Tipo de Fila no Seleccionada");
    }

    if (this.tifi_ID !=0 && this.atra_ID != 0) {
      this.PService.getFilasPosiciones(this.tifi_ID,this.atra_ID).subscribe((data) => {
        this.fila = data;
        if (data[0] && data[0].fiat_ID) {
          this.fiat_ID = data[0].fiat_ID;
        }
        else{
          this.fiat_ID = 0
        }

        this.filasfiltradas = data;
        this.paginacionConfig.totalItems = this.fila.length;
        
      });
    }
  }

  filtrado(){
    this.filasfiltradas = this.fila.filter((fila) => {
      return (
        fila.cliente_Nombre.toLowerCase().includes(this.filtro.toLowerCase()) ||
        fila.fipo_HoraIngreso.toLowerCase().includes(this.filtro.toLowerCase()) ||
        fila.ticl_ID.toString().toLowerCase().includes(this.filtro.toLowerCase()) ||
        fila.fipo_ID.toString().toLocaleLowerCase().includes(this.filtro.toLowerCase())
      );

    });

    this.paginacionConfig.totalItems = this.filasfiltradas.length;

    this.paginacionConfig.totalItems = this.filasfiltradas.length;
    this.paginacionConfig.currentPage = 1;
    this.filasfiltradas = this.paginarFilas(this.filasfiltradas);
  }

  paginarFilas(data: Filas[]): Filas[] {
    const startIndex = (this.paginacionConfig.currentPage - 1) * this.paginacionConfig.itemsPerPage;
    return data.slice(startIndex, startIndex + this.paginacionConfig.itemsPerPage);
  }
  
  onChangeItemsPerPage(event: Event) {
    const selectedValue = (event.target as HTMLInputElement)?.value;
    if (selectedValue !== null) {
      this.paginacionConfig.itemsPerPage = parseInt(selectedValue, 10);
      this.paginacionConfig.currentPage = 1;
      this.filasfiltradas = this.paginarFilas(this.filasfiltradas);
    }
  }


  Insert(){
    var error = 0;
    if (this.ticl_ID=="") {
      this.TicketRe=true;
      error += 1;
    }
    if (this.atra_ID2 == 0) {
      this.AtraccionRe = true;
      error += 1;
    }    
    if (error>0) {
      ToastUtils.showWarningToast("Hay Campos Vacios");
      
    }
    else{
      this.PService.PostPosiciones(this.atra_ID2,this.ticl_ID)
      .subscribe((response: any) => {
        if ( response.code==200) {
          ToastUtils.showSuccessToast( response.message);
          setTimeout(() => {
            window.location.href = '/filas'
          }, 800);
        }
        if ( response.code==409) {
          ToastUtils.showWarningToast( response.message);   
        }
        if ( response.code==500) {
          ToastUtils.showErrorToast("Ha ocurrido un error inesperado");   
        }
      });
    }
  }

  
  Delete(){
    this.PService.DeletePosicion(this.fipo_ID)
    .subscribe((response: any) => {
      if ( response.code==200) {
        ToastUtils.showSuccessToast( response.message);
        setTimeout(() => {
          window.location.href = '/filas'
        }, 800);
      }
      if ( response.code==409) {
        ToastUtils.showWarningToast( response.message);   
      }
      if ( response.code==500) {
        ToastUtils.showErrorToast("Ha ocurrido un error inesperado");   
      }
    });
  }

  DeleteCompleto(){

    if (this.atra_ID==0 || this.fiat_ID==0) {
      ToastUtils.showWarningToast("No ha escogido la atracción o su fila para actualizar la nueva información");
      return;
    }

    this.PService.DeletePosiciones(this.atra_ID,this.fiat_ID)
    .subscribe((response: any) => {
      if ( response.code==200) {
        ToastUtils.showSuccessToast( response.message);
        setTimeout(() => {
          window.location.href = '/filas'
        }, 800);
      }
      if ( response.code==409) {
        ToastUtils.showWarningToast( response.message);   
      }
      if ( response.code==500) {
        ToastUtils.showErrorToast("Ha ocurrido un error inesperado");   
      }
    });
  }

  Limpiar(){
    this.atra_ID = 0;
    this.ticl_ID = "";   
    this.AtraccionRe=false;
    this.TicketRe=false;
  }
    
  Modal(data:Filas){
    this.fipo_ID = data.fipo_ID;
  }
}
