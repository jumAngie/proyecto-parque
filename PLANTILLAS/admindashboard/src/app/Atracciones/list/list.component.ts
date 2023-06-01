import { Component, OnInit } from '@angular/core';
import { Router, RouterEvent, TitleStrategy } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { GraficaComponent } from 'src/app/grafica/grafica.component';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListAtraccionesComponent implements OnInit {
  atracciones!: Atracciones[];
  p: number = 1;
  filtro: string = '';
  deleteID!: number;

  constructor(
    private service: ParqServicesService,
    private router: Router,
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
      return atracciones.atra_Nombre.toLowerCase().includes(this.filtro.toLowerCase());
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

  getDeleteData(id: number): void{    
    this.deleteID = id;
    console.log(this.deleteID);
  }

  EliminarAtraccion(){
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
    })
  }
}
