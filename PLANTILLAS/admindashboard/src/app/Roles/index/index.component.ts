import { Component, ElementRef, Input, OnInit, Renderer2 } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';
import { Roles } from 'src/app/Models/Roles';
import { FormBuilder, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { Pantallas } from 'src/app/Models/Pantallas';
import { NgbNavChangeEvent } from '@ng-bootstrap/ng-bootstrap';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss'],
  
})
export class IndexComponent implements OnInit {
  rol: Roles[] = [];
  pantallas: Pantallas[] = [];
  pantallasenvio: Pantallas[] = [];
  rolinsert: Roles = new Roles();
  selectedRol: Roles = new Roles();
  p: number = 1;
  filtro: string = '';
  openDropdownIds: number[] = [];
	active = 1;
  tabEnabledStatus: boolean[] = [true, false]; 
  rolEnvio: number=0 ;
  people: any[] = [];
  selectedPeople = [];
  selectedPantallas = [];
  itemsPerPage: number = 6;

  
  NombreRolRequerido = false;
  NombreRolRequeridoUP=false;

isTabEnabled(tabNumber: number): boolean {
  return this.tabEnabledStatus[tabNumber - 1];
}

goToNextTab(): void {
this.tabEnabledStatus[this.active - 1] = false;
this.active=1;
this.tabEnabledStatus[this.active - 1] = true;
this.NombreRolRequerido = false;
this.rolinsert.role_Nombre="";
this.selectedPeople = [];
this.selectedPantallas = [];
}



onNavChange(changeEvent: NgbNavChangeEvent) {
  if (changeEvent.nextId == 1 || changeEvent.nextId == 2) {
    changeEvent.preventDefault();
  }
}

assignLater(): void {
  
}

saveUpdatePantallas(): void {
  const usua_ID = localStorage.getItem('usua_ID');
  if (usua_ID == null) {
    this.router.navigate(['pages-login']);
  }
  this.pantallasenvio = this.selectedPantallas.map((position, index) => {
    return {
      pant_Id: position,
      pant_Descripcion: "", // Asigna la descripción adecuada si está disponible
      role_ID: this.rolEnvio,
      ropa_UsuarioCreador: parseInt(usua_ID ?? '') 

    };
  });

    this.service.RolPantPantallasEliminado( this.rolEnvio).subscribe(
      (response: any) => {
        console.log(response)
      },
      (error: any) => {
        console.error('Error del servicio:', error);
        // Maneja el error de acuerdo a tus necesidades
      }
    );
 
  this.pantallasenvio.forEach((pantalla) => {
    this.service.RolPantPantallasElim(pantalla).subscribe(
      (response: any) => {
        console.log('Pantalla enviada:', pantalla);
        console.log('Respuesta del servicio:', response);
        // Realiza las acciones adicionales con la respuesta del servicio según tus necesidades
      },
      (error: any) => {
        console.error('Error al enviar la pantalla:', pantalla);
        console.error('Error del servicio:', error);
        // Maneja el error de acuerdo a tus necesidades
      }
    );
  });
}

save(): void {
  const usua_ID = localStorage.getItem('usua_ID');
  if (usua_ID == null) {
    this.router.navigate(['pages-login']);
  }
  this.pantallasenvio = this.selectedPeople.map((position, index) => {
    return {
      pant_Id: position,
      pant_Descripcion: "", // Asigna la descripción adecuada si está disponible
      role_ID: this.rolEnvio,
      ropa_UsuarioCreador: parseInt(usua_ID ?? '')
    };
    
  });

  console.log(this.pantallasenvio);
  
  this.pantallasenvio.forEach((pantalla) => {
    this.service.RolPantAgg(pantalla).subscribe(
      (response: any) => {
        console.log('Pantalla enviada:', pantalla);
        console.log('Respuesta del servicio:', response);
        // Realiza las acciones adicionales con la respuesta del servicio según tus necesidades
      },
      (error: any) => {
        console.error('Error al enviar la pantalla:', pantalla);
        console.error('Error del servicio:', error);
        // Maneja el error de acuerdo a tus necesidades
      }
    );
  });
}



  constructor(private service: AcceService, private router: Router, private elementRef: ElementRef,
    private renderer2: Renderer2,
    ) {}  

  // acciones
  toggleDropdown(roleId: number) {
    if (this.isDropdownOpen(roleId)) {
      this.closeDropdown(roleId);
    } else {
      this.openDropdown(roleId);
    }
  }

  isDropdownOpen(roleId: number): boolean {
    return this.openDropdownIds.includes(roleId);
  }

  openDropdown(roleId: number): void {
    if (!this.isDropdownOpen(roleId)) {
      // Cerrar los elementos abiertos
      this.closeAllDropdowns();

      this.openDropdownIds.push(roleId);
    }
  }

  closeDropdown(roleId: number): void {
    const index = this.openDropdownIds.indexOf(roleId);
    if (index !== -1) {
      this.openDropdownIds.splice(index, 1);
    }
  }

  closeAllDropdowns(): void {
    this.openDropdownIds = [];
  }
  //!acciones

  // cargar datos al modal
  selectRol(rol: Roles) {
    this.NombreRolRequeridoUP = false;
    this.selectedRol = { ...rol };
  }

  selectRolID(rol: Roles) {
    this.selectedRol = { ...rol };
  }

  selectRolFP(rol: Roles) {
    this.selectedRol = { ...rol };
    this.service.RolPantCK(this.selectedRol).subscribe(
      (response: any) => {
        console.log(response);
        this.selectedPantallas = response.map((item: any) => item.pant_Id);
        this.rolEnvio = rol.role_Id;
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }
  
  //!cargar datos al modal
  ngOnInit(): void {
    this.cargarLosDatos();
  }

  cargarLosDatos(){
    this.service.getRoles().subscribe((data) => {
      this.rol = data;
      
    });
    
    this.service.getPantallas().subscribe((data) => {
      this.pantallas = data;
      console.log(data)
      this.people = data.map((item) => ({
        pant_Id: item.pant_Id,
        pant_Descripcion: item.pant_Descripcion
      }));
      console.log(this.people);
    });
  }
  
  filtrarRoles(): Roles[] {
    return this.rol.filter((rol) => {
      return rol.role_Nombre.toLowerCase().includes(this.filtro.toLowerCase())||
              rol.role_Id.toString().toLowerCase().includes(this.filtro.toLowerCase());

    });
  }

  recarga(){ 
      this.service.getRoles().subscribe((data) => {
        this.rol = data;
      });
  }
  
  
  
  InsertRol() {
    
    if(this.rolinsert.role_Nombre=="" || this.rolinsert.role_Nombre==null || this.rolinsert.role_Nombre==undefined){
      ToastUtils.showWarningToast("Hay Campos Vacios");   
      this.NombreRolRequerido=true;
    }
    else{
      
      
      this.service.InsertRoles(this.rolinsert).subscribe(
        (response: any) => {
          console.log(response);
          this.rolEnvio = response[1].codeStatus
          console.log(this.rolEnvio);
          if ( response[0].codeStatus==200) {
            ToastUtils.showSuccessToast( response[0].messageStatus);
            this.tabEnabledStatus[this.active - 1] = false;
            this.active++;
            this.tabEnabledStatus[this.active - 1] = true;
            this.cargarLosDatos();
          }
          if ( response[0].codeStatus==409) {
            ToastUtils.showWarningToast( response[0].messageStatus);   
          }
          if ( response[0].codeStatus==500) {
            ToastUtils.showErrorToast( response[0].messageStatus);   
          }
        },
        (error: any) => {
          console.error('Error al guardar el rol', error);
        }
        );
    }
    }
    
      EditarRol() {
        if (this.selectedRol.role_Nombre=="") {
          ToastUtils.showWarningToast("Hay Campos Vacios");   
          this.NombreRolRequeridoUP=true;
        }
        else{
        this.service.EditarRol(this.selectedRol).subscribe(
          (response: any) => {
            console.log(response.code);
            this.NombreRolRequeridoUP=false;
            if ( response.code==200) {
              ToastUtils.showSuccessToast( response.message);
              this.cargarLosDatos();
            }
            if ( response.code==409) {
              ToastUtils.showWarningToast( response.message);   
            }
            if ( response.code==500) {
              ToastUtils.showErrorToast( response.message);   
            }
          },
          (error: any) => {
            console.error('Error al guardar el rol', error);
          }
        );
      }
      }

      DeleteRol() {
        console.log(this.selectedRol)
        this.service.DeleteRol(this.selectedRol).subscribe(
          (response: any) => {
            console.log(response.code);
            if ( response.code==200) {
              ToastUtils.showSuccessToast( response.message);
              this.cargarLosDatos();
            }
            if ( response.code==409) {
              ToastUtils.showWarningToast( response.message);   
            }
            if ( response.code==500) {
              ToastUtils.showErrorToast( response.message);   
            }
          },
          (error: any) => {
            console.error('Error al guardar el rol', error);
          }
        );
      }
      

  
  onChangeItemsPerPage(event: Event) {
    const selectedValue = (event.target as HTMLInputElement)?.value;
    if (selectedValue !== null) {
      const itemsPerPage = parseInt(selectedValue, 10);
      // Resto del código aquí
    }
  }
  
}
  