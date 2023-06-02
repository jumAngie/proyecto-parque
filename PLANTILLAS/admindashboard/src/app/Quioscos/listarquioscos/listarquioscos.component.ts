import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { Quioscos } from 'src/app/Models/Quioscos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { ImgbbService } from 'src/app/Service_IMG/imgbb-service.service';

@Component({
  selector: 'app-listarquioscos',
  templateUrl: './listarquioscos.component.html',
  styleUrls: ['./listarquioscos.component.css']
})

export class ListarquioscosComponent implements OnInit{
  quioscos!: Quioscos[];
  deleteID: any;

  filtro: String = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página

  showModalD=false;
  

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef,
    private renderer2: Renderer2,
    private imgbbService: ImgbbService,
  ){};

  ngOnInit(): void{

    this.getQuioscos();
    this.showModalD=false;
  };


  getQuioscos(){
    this.service.getQuioscos().subscribe((response: any) =>{
      if(response.success){
        this.quioscos = response.data;        
      }
    });
  };
  
  filtrarQuioscos(): Quioscos[]{
    const filtroLowerCase = this.filtro.toLowerCase();

    return this.quioscos.filter(quiosco => {
        const nombreValido = quiosco.quio_Nombre.toLowerCase().includes(filtroLowerCase);
        const direccionValido = quiosco.quio_ReferenciaUbicacion.toLowerCase().includes(filtroLowerCase);
        const areaNombreValido = quiosco.area_Nombre.toLowerCase().includes(filtroLowerCase);

        return nombreValido || direccionValido || areaNombreValido
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
    this.deleteID = rowData.quio_ID;
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
    this.service.deleteQuiosco(this.deleteID).subscribe((response : any) =>{
      if(response.code == 200){
        ToastUtils.showSuccessToast(response.message);
        this.getQuioscos();
      }else if(response.code == 409){
        ToastUtils.showWarningToast(response.message);
      }else{
        ToastUtils.showErrorToast(response.message);
      }
      this.closeDeleteModal();
    })
  }

};
