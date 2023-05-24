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
  areasForStile: {area_ID: String, isSelected: boolean, area_Nombre: String}[] = [];
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

      this.areasForStile = this.areas.map(item => ({area_ID: item.area_ID.toString(), isSelected: false, area_Nombre: item.area_Nombre}));
      console.log(this.areasForStile);
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
    this.atracciones.area_ID = parseInt(cartaId);
    console.log(this.atracciones.area_ID);
    
    // Lógica para cambiar el estado de selección de la carta
    this.areasForStile.forEach(carta => {
      carta.isSelected = carta.area_ID === cartaId;
    });

  }  

  selectedImage: any;

handleImageChange(event: any) {
  const file = event.target.files[0];
  const reader = new FileReader();
  
  reader.onload = (e: any) => {
    this.selectedImage = e.target.result;
  };

  reader.readAsDataURL(file);
}

removeImage(){
  this.selectedImage = null;
}

}
