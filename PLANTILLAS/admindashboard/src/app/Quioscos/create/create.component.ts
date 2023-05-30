import { Component, OnInit } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Quioscos } from 'src/app/Models/Quioscos';
import { Areas } from 'src/app/Models/Areas';
import { Regiones } from 'src/app/Models/Regiones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { Empleados } from 'src/app/Models/Empleados';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})

export class CreateQuioscoComponent implements OnInit{
  quiosco: Quioscos = new Quioscos();
  areas!: Areas[];
  regiones!: Regiones[];
  empleados!: Empleados[];

  areasForStyle: {area_ID: String, isSelected: boolean, area_Nombre: String}[] = [];
  selectedImage: any;

  //VALIRABLES PARA VALIDACIÓN DE S
  AreaRequerido = false;
  NombreRequerido = false;
  EmpleadoRequerido = false;
  RegionRequerido = false;
  UbicacionRequerido = false;

  constructor(
    private service: ParqServicesService,
    private router: Router,
  ){};
  ngOnInit(): void {
    this.getAreas();
    this.getRegiones();
    this.getEmpleados();
  }

  getAreas(){
    this.service.getAreas().subscribe((response: any) =>{
      if(response.success){
        this.areas = response.data;
      }
      this.areasForStyle = this.areas.map(item => ({area_ID: item.area_ID.toString(), isSelected: false, area_Nombre: item.area_Nombre}));      
    })
  };

  getRegiones(){
    this.service.getRegiones().subscribe((response: any) =>{
      if(response.success){
        this.regiones = response.data;
      }
    })
  };

  getEmpleados(){
    this.service.getEmpleados().subscribe((response: any) =>{
      if(response.success){
        this.empleados = response.data;
      }
    })
  }

  Guardar(){
    var errors = 0;
    const errorsArray: boolean[] = [];
    
    errorsArray[0] = this.validarArea();
    errorsArray[1] = this.validarEmpleado();
    errorsArray[2] = this.validarNombre ();
    errorsArray[3] = this.validarRegion();
    errorsArray[4] = this.validarUbicacion();

    for (let i = 0; i < errorsArray.length; i++) {
      if(errorsArray[i] == true){
        errors++;
      }else{
        errors;
      }
    }

    if(errors == 0){
      this.quiosco.quio_UsuarioCreador = 1;
      this.service.createQuioscos(this.quiosco).subscribe((response: any) =>{
        if(response.code == 200){
          ToastUtils.showSuccessToast(response.message);
          this.router.navigate(['quioscos-listado']);
        }else if(response.code == 409){
          ToastUtils.showWarningToast(response.message);
        }else{
          ToastUtils.showErrorToast(response.message);
        }
      })
    }else{
      ToastUtils.showWarningToast('Hay campos vacíos!')
    }
  }

  validarNombre(){
    if(!this.quiosco.quio_Nombre){
      this.NombreRequerido = true;
      return true;
    }else{
      this.NombreRequerido = false;
      return false;
    }
  };

  validarEmpleado(){
    if(!this.quiosco.empl_ID){
      this.EmpleadoRequerido = true;
      return true;
    }else{
      this.EmpleadoRequerido = false;
      return false;
    }
  };

  validarArea(){
    if(!this.quiosco.area_ID){
      this.AreaRequerido = true;
      return true;
    }else{
      this.AreaRequerido = false;
      return false;
    }
  };

  validarRegion(){
    if(!this.quiosco.regi_ID){
      this.RegionRequerido = true;
      return true;
    }else{
      this.RegionRequerido = false;
      return false;
    }
  };

  validarUbicacion(){
    if(!this.quiosco.quio_ReferenciaUbicacion){
      this.UbicacionRequerido = true;
      return true;
    }else{
      this.UbicacionRequerido = false;
      return false;
    }
  }

  clearNombreError(){
    if (this.quiosco.quio_Nombre.trim() !== '') {
      this.NombreRequerido = false;
    }    
  }

  clearUbicacionError(){
    if (this.quiosco.quio_ReferenciaUbicacion.trim() !== '') {
      this.UbicacionRequerido = false;
    }    
  }

  clearEmpleadoError(){
    if(this.quiosco.empl_ID.toString() != '' || this.quiosco.empl_ID != 0){
      this.EmpleadoRequerido = false;
    }
  }

  clearRegionError(){
    if(this.quiosco.regi_ID.toString() != '' || this.quiosco.regi_ID != 0){
      this.RegionRequerido = false;
    }
  }

  clearAreaError(){
    if(this.quiosco.area_ID.toString() != '' || this.quiosco.area_ID != 0){
      this.AreaRequerido = false;
    }    
  }

  Volver(){
    this.router.navigate(['quioscos-listado']);
  }

  mostrarIdCarta(cartaId: string) {
    this.quiosco.area_ID = parseInt(cartaId);
    this.clearAreaError();
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
  }
}
