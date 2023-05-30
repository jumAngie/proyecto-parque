import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Areas } from 'src/app/Models/Areas';
import { Atracciones } from 'src/app/Models/Atracciones';
import { Regiones } from 'src/app/Models/Regiones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';



@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})

export class CreateAtraccionesComponent implements OnInit {
  atracciones: Atracciones = new Atracciones();
  areas!: Areas[];
  regiones!: Regiones[];
  areasForStyle: {area_ID: String, isSelected: boolean, area_Nombre: String, area_Imagen: String}[] = [];
  selectedImage: any;
  
  @ViewChild('imageInput') imageInput!: ElementRef<HTMLInputElement>;


  //VALIRABLES PARA VALIDACIÓN DE S
  NombreRequerido = false;
  DescripcionRequerido = false;
  UbicacionRequerido = false;
  LimitePersonasRequerido = false;
  DuracionRondaRequerido = false;
  RegionRequerido = false;
  AreaRequerido = false;

  
  constructor(
    private service: ParqServicesService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.atracciones.regi_ID = 0;

    this.service.getAreas()
    .subscribe((response: any) =>{
      if(response.success){
        this.areas = response.data;
      }
      this.areasForStyle = this.areas.map(item => ({area_ID: item.area_ID.toString(), isSelected: false, area_Nombre: item.area_Nombre, area_Imagen: item.area_Imagen}));
    })


    this.service.getRegiones()
    .subscribe((response: any) =>{
      if(response.success){
        this.regiones = response.data;
      }
    })
  }

  Guardar(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    errorsArray[0] = this.validarNombre();
    errorsArray[1] = this.validarDescripcion();
    errorsArray[2] = this.validarUbicacionReferencia();
    errorsArray[3] = this.validarLimitePersonas();
    errorsArray[4] = this.validarTiempoDuracion();
    errorsArray[5] = this.validarRegion();
    errorsArray[6] = this.validarArea();

    for (let i = 0; i < errorsArray.length; i++) {
      if(errorsArray[i] == true){
        errors++;
      }
      else{
        errors;
      }  
    }

    if(errors == 0){
      this.atracciones.atra_UsuarioCreador = 1;
      this.service.insertAtracciones(this.atracciones)
      .subscribe((response: any) =>{
        console.log(response)
        if(response.code == 200){
          ToastUtils.showSuccessToast(response.message);          
          this.router.navigate(['atracciones-listado']);
        }else if(response.code == 409){
          ToastUtils.showWarningToast(response.message);
        }
        else{
          ToastUtils.showErrorToast(response.message);
        }
      })
    }else{
      ToastUtils.showWarningToast('Hay campos vacíos!');
    }
  };

  validarNombre() {
    if(!this.atracciones.atra_Nombre){
      this.NombreRequerido = true;
      //ToastUtils.showWarningToast('Campo "Nombre" requerido');
      return true;
    }else{
      this.NombreRequerido = false;
      return false;
    }
  }

  validarDescripcion(){
    if(!this.atracciones.atra_Descripcion){
      this.DescripcionRequerido = true;
      //ToastUtils.showWarningToast('Campo "Descripción" requerido');
      return true;
    }else{
      this.DescripcionRequerido = false;
      return false;
    }
  }

  validarUbicacionReferencia(){      
    if(!this.atracciones.atra_ReferenciaUbicacion){
      this.UbicacionRequerido = true;
      //ToastUtils.showWarningToast('Campo "Ubicación Referencia" requerido');
      return true;
    }else{
      this.UbicacionRequerido = false;
      return false;
    }
  }

  validarLimitePersonas(){
    if(!this.atracciones.atra_LimitePersonas){
      this.LimitePersonasRequerido = true;
      //ToastUtils.showWarningToast('Campo "Límite personas" requerido');
      return true;
    }else{
      this.LimitePersonasRequerido = false;
      return false;
    }
  }

  validarTiempoDuracion(){
    if(!this.atracciones.atra_DuracionRonda){
      this.DuracionRondaRequerido = true;
      //ToastUtils.showWarningToast('Campo "Duración ronda" requerido');
      return true;
    }else{
      this.DuracionRondaRequerido = false;
      return false;
    }
  }

  validarRegion(){
    if(!this.atracciones.regi_ID){
      this.RegionRequerido = true;
      //ToastUtils.showWarningToast('Campo "Región" requerido');
      return true;
    }else{
      this.RegionRequerido = false;
      return false;
    }
  }

  validarArea(){
    if(!this.atracciones.area_ID){
      this.AreaRequerido = true;
      //ToastUtils.showWarningToast('Debes seleccionar una Zona')
      return true;
    }else{
      this.AreaRequerido = false;
      return false;
    }
  }

  clearNombreError(){
    if (this.atracciones.atra_Nombre.trim() !== '') {
      this.NombreRequerido = false;
    }    
  }

  clearDescripcionError(){
    if (this.atracciones.atra_Descripcion.trim() !== '') {
      this.DescripcionRequerido = false;
    }    
  }

  clearUbicacionError(){
    if (this.atracciones.atra_ReferenciaUbicacion.trim() !== '') {
      this.UbicacionRequerido = false;
    }    
  }

  clearLimitePersonasError(){
    if(this.atracciones.atra_LimitePersonas.toString().trim() !== ''){
      this.LimitePersonasRequerido = false;
    }
  }

  clearDuracionRondaError(){
    if(this.atracciones.atra_DuracionRonda.trim() !== ''){
      this.DuracionRondaRequerido = false;
    }
  }

  clearRegionError(){
    if(this.atracciones.regi_ID.toString() != '' || this.atracciones.regi_ID != 0){
      this.RegionRequerido = false;
    }
  }

  clearAreaError(){
    if(this.atracciones.area_ID.toString() != '' || this.atracciones.area_ID != 0){
      this.AreaRequerido = false;
    }    
  }

  Volver(){
    this.router.navigate(['atracciones-listado']);
  }

  // Función para manejar el clic en una carta
  mostrarIdCarta(cartaId: string) {
    this.atracciones.area_ID = parseInt(cartaId);
    this.clearAreaError();
    console.log(this.atracciones.area_ID);
    // Lógica para cambiar el estado de selección de la carta
    this.areasForStyle.forEach(carta => {
      carta.isSelected = carta.area_ID === cartaId;
    });
  }  
  
  handleImageChange(event: any) {
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onload = (e: any) => {
      this.selectedImage = e.target.result;
    };
    
    reader.readAsDataURL(file);
  }

  removeImage(){
    this.selectedImage = '';
    this.imageInput.nativeElement.value = '';
  }



}
