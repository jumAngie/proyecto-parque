import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { ImgbbService } from 'src/app/Service_IMG/imgbb-service.service';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListAtraccionesComponent implements OnInit {
  atracciones!: Atracciones[];
  filtro: String = '';
  p: number = 1;
  selectedPageSize = 2;
  pageSizeOptions: number[] = [2, 4 ,6, 8]; // Opciones de tamaño de página

  showModalD=false;
  deleteID!: number;

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,
    private imgbbService: ImgbbService,
  ) { }

  ngOnInit(): void {
    this.getAtracciones();
  }
  
  getAtracciones(){
    this.service.getAtracciones()
      .subscribe((response: any) => {
        if (response.success) {
          this.atracciones = response.data;
        }
      });
  };


  filtrarAtracciones(): Atracciones[] {
    return this.atracciones.filter(atracciones => {
      const atraccion = atracciones.atra_Nombre.toLowerCase().includes(this.filtro.toLowerCase());

      return atraccion
    });
  }

  AgregarAtraccion(){
    this.router.navigate(['atracciones-crear'])
  }

  EditarAtraccion(atracciones: Atracciones): void{
    localStorage.setItem('atra_ID', atracciones.atra_ID?.toString());
    this.router.navigate(['atracciones-editar']);
  }

  detailAtraccion(atracciones: Atracciones){
    localStorage.setItem('atra_Detail_ID', atracciones.atra_ID?.toString());
    this.router.navigate(['atracciones-detalle']);
  }




//#region MODAL DELETE 
onDelete(id: number){
  this.deleteID = id;
  this.openDeleteModal();
}

openDeleteModal() {
  const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
  this.renderer2.setStyle(modalDelete, 'display', 'block');
  setTimeout(() => {
    this.renderer2.addClass(modalDelete, 'show');
    this.showModalD = true;
  }, 0);
}

closeDeleteModal() {
  const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
  this.renderer2.removeClass(modalDelete, 'show');
  setTimeout(() => {
    this.renderer2.setStyle(modalDelete, 'display', 'none');
    this.showModalD = false;
  }, 300); // Ajusta el tiempo para que coincida con la duración de la transición en CSS
}


confirmDelete(){
  this.service.deleteAtracciones(this.deleteID).subscribe((response: any) =>{
    console.log(response);
    if(response.code == 200){
      ToastUtils.showSuccessToast(response.message);
      this.getAtracciones();        
    }else if(response.code == 409){
      ToastUtils.showWarningToast(response.message);
    }else{
      ToastUtils.showErrorToast(response.message);
    }
    this.closeDeleteModal();
  })
}

//#endregion MODAL DELETE


}
