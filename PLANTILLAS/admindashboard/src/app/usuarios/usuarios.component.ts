import { Component, ElementRef } from '@angular/core';
import { Usuarios } from '../Models/Usuarios';
import { AcceService } from '../Service/acce.service';
import { ParqServicesService } from '../ParqServices/parq-services.service';
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
  usuariosFiltrados: Usuarios[] = []; // Nuevo arreglo para almacenar los usuarios filtrados
  openDropdownIds: number[] = [];
  InsertUsu: Usuarios = new Usuarios();
  selectedUsu: Usuarios = new Usuarios();
  ddlRol: Roles[] = [];
  ddlEmpleado: Empleados[] = [];
  filtro: string = '';
  p: number = 1;

  paginacionConfig: any = {
    itemsPerPage: 10, // Cantidad de elementos por página
    currentPage: 1, // Página actual
    totalItems: 0 // Total de elementos en la tabla (se actualizará en la carga de datos)
  };

  constructor(
    private service: AcceService,
    private router: Router,
    private elementRef: ElementRef,
    private PService: ParqServicesService
  ) {}

  ngOnInit(): void {
    this.service.getUsuarios().subscribe((data) => {
      this.usuario = data;
      this.usuariosFiltrados = data; // Inicialmente, los usuarios filtrados serán los mismos que los usuarios totales
      this.paginacionConfig.totalItems = this.usuario.length; // Actualiza el total de elementos en la tabla
    });

    this.service.getUsuarios().subscribe((data) => {
      this.usuariosFiltrados = data;
      this.paginacionConfig.totalItems = this.usuariosFiltrados.length;
    });

    this.service.getRoles().subscribe((data) => {
      this.ddlRol = data;
    });

    this.PService.getEmpleados().subscribe((response: any) => {
      if (response.success) {
        this.ddlEmpleado = response.data;
      }
    });
  }


  paginarUsuarios(data: Usuarios[]): Usuarios[] {
    const startIndex = (this.paginacionConfig.currentPage - 1) * this.paginacionConfig.itemsPerPage;
    return data.slice(startIndex, startIndex + this.paginacionConfig.itemsPerPage);
  }

  filtrarUsuarios() {
    this.usuariosFiltrados = this.usuario.filter((usuario) => {
      return (
        usuario.usua_Usuario.toLowerCase().includes(this.filtro.toLowerCase()) ||
        usuario.nombreEmpleado.toLowerCase().includes(this.filtro.toLowerCase()) ||
        usuario.usua_ID.toString().toLowerCase().includes(this.filtro.toLowerCase()) ||
        usuario.role_Descripcion.toLowerCase().includes(this.filtro.toLowerCase())
      );
    });

    this.paginacionConfig.totalItems = this.usuariosFiltrados.length; // Actualiza el total de elementos en la tabla filtrada

    this.paginacionConfig.totalItems = this.usuariosFiltrados.length;
    this.paginacionConfig.currentPage = 1; // Reiniciar la página a 1 después de filtrar
    this.usuariosFiltrados = this.paginarUsuarios(this.usuariosFiltrados); // Obtener usuarios paginados
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
  // !acciones

  // cargar datos al modal
  selectUsuario(usu: Usuarios) {
    usu.usua_Clave = '';
    this.selectedUsu = { ...usu };
  }

  selectUsuarioID(usu: Usuarios) {
    this.selectedUsu = { ...usu };
  }
  // !cargar datos al modal

  // CRUD
  Insert() {
    this.service.InsertUsuario(this.InsertUsu).subscribe(
      (response: any) => {
        console.log(response);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  Update() {
    this.service.UpdateUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  Delete() {
    this.service.DeleteUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  Pass() {
    this.service.PassUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }
  // !CRUD

  cambiarItemsPerPage(cantidad: number) {
    this.paginacionConfig.itemsPerPage = cantidad;
  }
}
