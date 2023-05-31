import { TitleCasePipe } from '@angular/common';
import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { Golosinas } from 'src/app/Models/Golosinas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-listgolosinas',
  templateUrl: './listgolosinas.component.html',
  styleUrls: ['./listgolosinas.component.scss']
})
export class ListgolosinasComponent implements OnInit {
  golosinas!: Golosinas[];
  updateGolosina: Golosinas = new Golosinas(); 
  createGolosina: Golosinas = new Golosinas();
  golo_ID: any;

  p: number = 1;
  filtro: string = '';

  Golosina_Create_Requerido = false;
  Precio_Create_Requerido = false;

  Golosina_Update_Requerido = false;
  Precio_Update_Requerido = false;


  constructor(
    private service:ParqServicesService,
    private elementRef: ElementRef,
    private renderer2: Renderer2,

  ) { }

  ngOnInit(): void {
  
    this.getGolosinas();
    this.createGolosina.golo_Precio = 0;
  }
  
  getGolosinas(){
    this.service.getGolosinas()
    .subscribe((response: any) =>{
      console.log(response);
      if (response.success) {
          this.golosinas = response.data;
      }
    })
  }

  filtrarGolosinas(): Golosinas[] {
    const filtroLowerCase = this.filtro.toLowerCase();
  
    return this.golosinas.filter(golosinas => {
      const nombreValido = golosinas.golo_Nombre.toLowerCase().includes(filtroLowerCase);
      const idValido = golosinas.golo_ID.toString().includes(this.filtro);
      const precioValido = golosinas.golo_Precio.toString().includes(this.filtro);
  
      return nombreValido || idValido || precioValido;
    });
  };


//#region MODAL CREATE
openCreateModal(){
  const modalCreate = this.elementRef.nativeElement.querySelector('#modalCreate');
  this.renderer2.addClass(modalCreate, 'show');
  this.renderer2.setStyle(modalCreate, 'display', 'block');

}
closeCreateModal(){
  const modalCreate = this.elementRef.nativeElement.querySelector('#modalCreate');
  this.renderer2.removeClass(modalCreate, 'show');
  this.renderer2.setStyle(modalCreate, 'display', 'none');
  
  this.createGolosina.golo_UsuarioCreador = 0;
  this.createGolosina.golo_Nombre = '';
  this.createGolosina.golo_Precio = 0;

  const golo_Nombre = this.elementRef.nativeElement.querySelector('#golo_Nombre');
  this.renderer2.setProperty(golo_Nombre, 'value', '');

  const golo_Precio = this.elementRef.nativeElement.querySelector('#golo_Precio');
  this.renderer2.setProperty(golo_Precio, 'value', '');
}

confirmCreate(){
  var errors = 0;
  const errorsArray: boolean[] = [];

  errorsArray[0] = this.validateGolosinaCreate();
  errorsArray[1] = this.validatePrecioCreate();

  for (let i = 0; i < errorsArray.length; i++) {
    if (errorsArray[i]  == true) {
      errors++;
    }else{
      errors;
    }    
  }

  if (errors == 0) {
    this.createGolosina.golo_UsuarioCreador = 1;
    this.service.createGolosina(this.createGolosina).subscribe((response : any) =>{
      if (response.code == 200) {
        ToastUtils.showSuccessToast(response.message);
        this.getGolosinas();
        this.closeCreateModal();
      }else if(response.code == 409){
        ToastUtils.showWarningToast(response.message);
      }else{
        ToastUtils.showErrorToast(response.message);
      }
    })
  }else{
    ToastUtils.showWarningToast('¡Hay campos vacíos!');
  }
}
//#endregion MODAL CREATE


//#region MODAL UPDATE
  onUpdate(golosinas: Golosinas){
    this.updateGolosina.golo_ID = golosinas.golo_ID;
    this.updateGolosina.golo_Nombre = golosinas.golo_Nombre;
    this.updateGolosina.golo_Precio = golosinas.golo_Precio;
    this.openUpdateModal();
  }

  confirmUpdate(){
    var errors = 0;
    const errorsArray: boolean[] = [];

    errorsArray[0] = this.validateGolosinaUpdate();
    errorsArray[1] = this.validatePrecioUpdate();

    for (let i = 0; i < errorsArray.length; i++) {
      if (errorsArray[i] == true) {
        errors++;
      }else{
        errors;
      }
    }

    if (errors == 0) {
        this.updateGolosina.golo_UsuarioModificador = 1;
        this.service.updateGolosina(this.updateGolosina).subscribe((response : any) =>{
          if(response.code == 200){
            ToastUtils.showSuccessToast(response.message);
            this.getGolosinas();
            this.closeUpdateModal();
          }else if (response.code == 409){
            ToastUtils.showWarningToast(response.message);
          }else{
            ToastUtils.showErrorToast(response.message);
          }
        })
    }else{
      ToastUtils.showWarningToast('Hay campos vacios!');
    }
  }

  openUpdateModal(){
    const modalUpdate = this.elementRef.nativeElement.querySelector('#modalUpdate');
    this.renderer2.addClass(modalUpdate, 'show');
    this.renderer2.setStyle(modalUpdate, 'display', 'block');
  }

  closeUpdateModal(): void {
    const modalUpdate = this.elementRef.nativeElement.querySelector('#modalUpdate');
    this.renderer2.removeClass(modalUpdate, 'show');
    this.renderer2.setStyle(modalUpdate, 'display', 'none');
  }
//#endregion MODAL UPDATE


//#region MODAL DELETE 
  onDelete(id: number){
    this.golo_ID = id;
    this.openDeleteModal();
  }

  openDeleteModal(){
    const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
    this.renderer2.addClass(modalDelete, 'show');
    this.renderer2.setStyle(modalDelete, 'display', 'block'); 
  }

  closeDeleteModal(){
    const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
    this.renderer2.removeClass(modalDelete, 'show');
    this.renderer2.setStyle(modalDelete, 'display', 'none');    
  }

  confirmDelete(){
    this.service.deleteGolosina(this.golo_ID).subscribe((response : any) =>{
      if (response.code == 200) {
        ToastUtils.showSuccessToast(response.message);
        this.getGolosinas();
      }else if(response.code == 409){
        ToastUtils.showWarningToast(response.message);
      }else{
        ToastUtils.showErrorToast(response.message);
      }
      this.closeDeleteModal();
    })
  }

//#endregion MODAL DELETE


  //#region  VALIDACIONES CREAR 
    validateGolosinaCreate(){
      if(!this.createGolosina.golo_Nombre){
        this.Golosina_Create_Requerido = true;
        return true;
      }else{
        this.Golosina_Create_Requerido = false;
        return false;
      }
    };

    validatePrecioCreate() {
      const regex = /^[0-9]+(\.[0-9]{1,2})?$/;

      if (!this.createGolosina.golo_Precio) {
        this.Precio_Create_Requerido = true;
        return true;
      } else if (!regex.test(this.createGolosina.golo_Precio.toString())) {
        this.Precio_Create_Requerido = true;
        ToastUtils.showWarningToast('Solo se aceptan valores numéricos')
        return true;
      } else {
        this.Precio_Create_Requerido = false;
        return false;
      }
    }
    

    clearGolosinaCreateError(){
      if(this.createGolosina.golo_Nombre){
        this.Golosina_Create_Requerido = false;
      }
    };

    clearPrecioCreateError(){
      if(this.createGolosina.golo_Precio){
        this.Precio_Create_Requerido = false;
      }
    }
  //#endregion


  //#region VALIDACIONES ACTUALIZAR
    validateGolosinaUpdate(){
      if (!this.updateGolosina.golo_Nombre) {
        this.Golosina_Update_Requerido = true;
        return true;
      }else{
        this.Golosina_Update_Requerido = false;
        return false;
      }
    }

    validatePrecioUpdate(){
      const regex = /^[0-9]+(\.[0-9]{1,2})?$/;

      if (!this.updateGolosina.golo_Nombre) {
        this.Precio_Update_Requerido = true;
        return true;      
      }else if (!regex.test(this.updateGolosina.golo_Precio.toString())) {
        this.Precio_Update_Requerido = true;
        ToastUtils.showWarningToast('Solo se aceptan valores numéricos')
        return true;
      } else{
        this.Precio_Update_Requerido = false;
        return false;
      }
    }

    clearGolosinaUpdateError(){
      if(this.updateGolosina.golo_Nombre){
        this.Golosina_Update_Requerido = false;
      }
    }

    clearPrecioUpdateError(){
      if (this.updateGolosina.golo_Precio) {
        this.Precio_Update_Requerido = false;
      }
    }
  //#endregion VALIDACIONES ACTUALIZAR 
}
