import { Component, OnInit } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Areas } from 'src/app/Models/Areas';
import { Atracciones } from 'src/app/Models/Atracciones';
import { Regiones } from 'src/app/Models/Regiones';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})

export class CreateAtraccionesComponent implements OnInit {
  atracciones: Atracciones = new Atracciones();
  areas!: Areas[];
  regiones!: Regiones[];

  constructor(
    private service: ParqServicesService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.service.getAreas()
    .subscribe((response: any) =>{
      if(response.success){
        this.areas = response.data;
      }
    })


    this.service.getRegiones()
    .subscribe((response: any) =>{
      if(response.success){
        this.regiones = response.data;
      }
    })
  }

  Guardar(){
    this.service.insertAtracciones(this.atracciones)
    .subscribe((response: any) =>{
      console.log(response)
      if(response.success){
        alert(response.data.message);
        this.router.navigate(['listatracciones']);
      }else{
        alert(response.data.message);
      }
    })
    
  }

  Volver(){
    this.router.navigate(['listatracciones']);
  }

  // Función para manejar el clic en una carta
  mostrarIdCarta(cartaId: string) {
    this.atracciones.area_ID = parseInt( cartaId);
  }  
}
