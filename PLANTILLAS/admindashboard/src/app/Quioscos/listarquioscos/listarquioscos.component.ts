import { Component, OnInit } from '@angular/core';
import { Quioscos } from 'src/app/Models/Quioscos';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

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


  constructor(
    private service: ParqServicesService,
    private router: Router,
  ){};

  ngOnInit(): void{

    this.getQuioscos();
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
  }

};
