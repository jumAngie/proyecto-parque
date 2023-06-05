import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Areas } from 'src/app/Models/Areas';
import { Atracciones } from 'src/app/Models/Atracciones';
import { Regiones } from 'src/app/Models/Regiones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { ImgbbService } from 'src/app/Service_IMG/imgbb-service.service';

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
  imageUrl: string = ''; 
  
  @ViewChild('imageInput') imageInput!: ElementRef<HTMLInputElement>;


  //VALIRABLES PARA VALIDACIÓN DE S
  NombreRequerido = false;
  DescripcionRequerido = false;
  UbicacionRequerido = false;
  LimitePersonasRequerido = false;
  DuracionRondaRequerido = false;
  RegionRequerido = false;
  AreaRequerido = false;
  ImagenRequerido = false;
  
  
  constructor(
    private service: ParqServicesService,
    private router: Router,
    private imgbbService: ImgbbService
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
    errorsArray[7] = this.validarImagen();

    for (let i = 0; i < errorsArray.length; i++) {
      if(errorsArray[i] == true){
        errors++;
      }
      else{
        errors;
      }  
    }

    if(errors == 0){
      const usua_ID = localStorage.getItem('usua_ID');
      if (usua_ID == null) {
        this.router.navigate(['pages-login']);
      }
      this.atracciones.atra_UsuarioCreador = parseInt(usua_ID ?? '');
      this.service.insertAtracciones(this.atracciones).subscribe((response: any) =>{
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
      return true;
    }else{
      this.NombreRequerido = false;
      return false;
    }
  }

  validarImagen() {
    if(!this.atracciones.atra_Imagen){
      this.ImagenRequerido = true;      
      return true;
    }else{
      this.ImagenRequerido = false;
      return false;
    }
  }

  validarDescripcion(){
    if(!this.atracciones.atra_Descripcion){
      this.DescripcionRequerido = true;      
      return true;
    }else{
      this.DescripcionRequerido = false;
      return false;
    }
  }

  validarUbicacionReferencia(){      
    if(!this.atracciones.atra_ReferenciaUbicacion){
      this.UbicacionRequerido = true;      
      return true;
    }else{
      this.UbicacionRequerido = false;
      return false;
    }
  }

  validarLimitePersonas(){
    const regex = /^[0-9]+(\.[0-9]{1,2})?$/;   
    
    if(!this.atracciones.atra_LimitePersonas){
      this.LimitePersonasRequerido = true;      
      return true;
    }else if(!regex.test(this.atracciones.atra_LimitePersonas.toString())){
      ToastUtils.showWarningToast('Solo se aceptan valores numéricos');
      this.LimitePersonasRequerido = true;      
      return true;
    }else if(this.atracciones.atra_LimitePersonas <= 1){      
      ToastUtils.showWarningToast('El limite de personas debe ser superior a uno');
      this.LimitePersonasRequerido = true;      
      return true;
    }else{
      this.LimitePersonasRequerido = false;
      return false;
    }
  }

  validarTiempoDuracion(){
    const regex = /^[0-9]+(\.[0-9]{1,2})?$/;

    if(!this.atracciones.atra_DuracionRonda){
      this.DuracionRondaRequerido = true;          
      return true;
    }else if(!regex.test(this.atracciones.atra_DuracionRonda.toString())){
      ToastUtils.showWarningToast('Solo se aceptan valores numéricos')      
      this.DuracionRondaRequerido = true;          
      return true;
    }else if(this.atracciones.atra_DuracionRonda <= 0){      
      ToastUtils.showWarningToast('La duración por ronda debe ser superior a uno.')      
      this.DuracionRondaRequerido = true;          
      return true;
    }
    else{
      this.DuracionRondaRequerido = false;
      return false;
    }
  }

  validarRegion(){
    if(this.atracciones.regi_ID == 0 || !this.atracciones.regi_ID){
      this.RegionRequerido = true;      
      return true;
    }else{
      this.RegionRequerido = false;
      return false;
    }
  }

  validarArea(){
    if( this.atracciones.area_ID == 0 || !this.atracciones.area_ID){
      this.AreaRequerido = true;      
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
    if(this.atracciones.atra_LimitePersonas.toString() !== '' || this.atracciones.atra_LimitePersonas != 0){
      this.LimitePersonasRequerido = false;
    }
  }

  clearDuracionRondaError(){
    if(this.atracciones.atra_DuracionRonda !=0 || this.atracciones.atra_DuracionRonda.toString() != ''){
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
    // Lógica para cambiar el estado de selección de la carta
    this.areasForStyle.forEach(carta => {
      carta.isSelected = carta.area_ID === cartaId;
    });
  }  
  
  handleImageUpload(event: any) {
    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = (e: any) => {

        this.uploadImageToServer(file);
      };
      reader.readAsDataURL(file);
    }
  }

  uploadImageToServer(file: File) {
    this.imgbbService.Upload_IMG(file)
      .subscribe(
        response => {

          this.imageUrl = response.data.url;
          this.atracciones.atra_Imagen = (this.imageUrl)
        },
        error => {
          // Manejar errores en la carga de la imagen
          console.error(error);
        }
      );
  }
  deleteImage() {
    this.imageUrl = "";
    this.atracciones.atra_Imagen="";
  }


}
