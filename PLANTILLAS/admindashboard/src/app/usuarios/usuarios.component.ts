import { Component, ElementRef } from '@angular/core';
import { Usuarios } from '../Models/Usuarios';
import { AcceService } from '../Service/acce.service';
import {ParqServicesService} from '../ParqServices/parq-services.service'
import { Router } from '@angular/router';
import { Roles } from '../Models/Roles';
import { Empleados } from '../Models/Empleados';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.css']
})
export class UsuariosComponent {
  usuario: Usuarios[] = [];
  openDropdownIds: number[] = [];
  InsertUsu: Usuarios = new Usuarios();
  selectedUsu: Usuarios = new Usuarios();
  ddlRol: Roles[] = [];
  ddlEmpleado: Empleados[] = [];

  

  constructor(private service: AcceService, private router: Router, private elementRef: ElementRef,private PService:ParqServicesService) {}  

  ngOnInit(): void {
    this.service.getUsuarios().subscribe((data) => {
      this.usuario = data;
      console.log(data)
    });

    this.service.getRoles().subscribe((data) => {
      this.ddlRol = data;
      console.log(this.ddlRol )
      
    });

    this.PService.getEmpleados().subscribe((data) => {
      this.ddlEmpleado = data;
      console.log(this.ddlEmpleado )
      
    });
  }

   // acciones
   toggleDropdown(usua_ID: number) {
    if (this.isDropdownOpen(usua_ID)) {
      this.closeDropdown(usua_ID);
    } else {
      this.openDropdown(usua_ID);
    }
  }

  isDropdownOpen(usua_ID: number): boolean {
    return this.openDropdownIds.includes(usua_ID);
  }

  openDropdown(usua_ID: number): void {
    if (!this.isDropdownOpen(usua_ID)) {
      this.closeAllDropdowns();

      this.openDropdownIds.push(usua_ID);
    }
  }

  closeDropdown(usua_ID: number): void {
    const index = this.openDropdownIds.indexOf(usua_ID);
    if (index !== -1) {
      this.openDropdownIds.splice(index, 1);
    }
  }

  closeAllDropdowns(): void {
    this.openDropdownIds = [];
  }
  //!acciones

  
  // cargar datos al modal
  selectUsuario(usu: Usuarios) {
    usu.usua_Clave="";
    this.selectedUsu = { ...usu };
  }

  selectUsuarioID(usu: Usuarios) {
    
    this.selectedUsu = { ...usu };
  }
  //!cargar datos al modal

  //CRUD
   Insert(){
    this.service.InsertUsuario(this.InsertUsu).subscribe(
      (response: any) => {
        console.log(response);

      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
      );
   }

   Update(){
    this.service.UpdateUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);

      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
      );
   }

   Delete(){
    this.service.DeleteUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);

      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
      );
   }

   Pass(){
    this.service.PassUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);

      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
      );
   }
  //!CRUD
}
