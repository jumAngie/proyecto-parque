import { Component, ElementRef, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';
import { Roles } from 'src/app/Models/Roles';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss']
})

export class IndexComponent implements OnInit {
  rol: Roles[] = [];
  selectedRol: Roles = new Roles();
  p: number = 1;
  filtro: string = '';
  openDropdownIds: number[] = [];
  constructor(private service: AcceService, private router: Router,private elementRef: ElementRef) { }

  //acciones
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

  //cargar datos al modal
  selectRol(rol: Roles) {
    this.selectedRol = { ...rol }; 
  }
  //!cargar datos al modal
  
  ngOnInit(): void {
    this.service.getRoles().subscribe(data => {
      this.rol = data;
      console.log(data);
    });
  }

  filtrarRoles(): Roles[] {
    return this.rol.filter(rol => {
      return rol.role_Nombre.toLowerCase().includes(this.filtro.toLowerCase());
    });
  }



  EditarRol() {
    this.service.EditarRol(this.selectedRol)
    .subscribe((response: any) => {
        console.log(response.code)
      }, (error: any) => {
        console.error('Error al guardar el rol', error);
      });
  }
}
