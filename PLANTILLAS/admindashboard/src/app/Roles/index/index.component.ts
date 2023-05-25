import { Component, ElementRef, Input, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';
import { Roles } from 'src/app/Models/Roles';
import { FormBuilder, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { Pantallas } from 'src/app/Models/Pantallas';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss'],
  
})
export class IndexComponent implements OnInit {
  rol: Roles[] = [];
  pantallas: Pantallas[] = [];
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


isTabEnabled(tabNumber: number): boolean {
  return this.tabEnabledStatus[tabNumber - 1];
}

goToNextTab(): void {
this.tabEnabledStatus[this.active - 1] = false;
this.active=1;
this.tabEnabledStatus[this.active - 1] = true;

}

assignLater(): void {
  // Lógica para asignar luego en la segunda pestaña
}

save(): void {
  // Lógica para guardar en la segunda pestaña
}

  constructor(private service: AcceService, private router: Router, private elementRef: ElementRef) {}

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
    this.selectedRol = { ...rol };
  }
  //!cargar datos al modal
  ngOnInit(): void {
    this.service.getRoles().subscribe((data) => {
      this.rol = data;
      this.people = data.map((item) => ({
        role_Nombre: item.role_Nombre,
        role_Id: item.role_Id
      }));
      console.log(this.people);
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
      return rol.role_Nombre.toLowerCase().includes(this.filtro.toLowerCase());
    });
  }



  EditarRol() {
    this.service.EditarRol(this.selectedRol).subscribe(
      (response: any) => {
        console.log(response.code);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }


  
  InsertRol() {
    this.tabEnabledStatus[this.active - 1] = false;
    this.active++;
    this.tabEnabledStatus[this.active - 1] = true;
    
    this.service.InsertRoles(this.rolinsert).subscribe(
      (response: any) => {
        console.log(response);
        this.rolEnvio = response[1].codeStatus
        console.log(this.rolEnvio);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  @Input() tabs: string[] = [];
  activeTab: string = '';

  setActiveTab(tab: string) {
    this.activeTab = tab;
  }
}
