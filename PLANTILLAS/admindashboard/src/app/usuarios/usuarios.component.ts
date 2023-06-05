import { Component, ElementRef, HostListener } from '@angular/core';
import { Usuarios } from '../Models/Usuarios';
import { AcceService } from '../Service/acce.service';
import { ParqServicesService } from '../ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Roles } from '../Models/Roles';
import { Empleados } from '../Models/Empleados';
import { ImgbbService } from '../Service_IMG/imgbb-service.service'
import { ToastUtils } from '../Utilities/ToastUtils';

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
  imageUrl: string = ''; 
  itemsPerPage: number = 3;
  paginacionConfig: any = {
    itemsPerPage: 10, // Cantidad de elementos por página
    currentPage: 1, // Página actual
    totalItems: 0 // Total de elementos en la tabla (se actualizará en la carga de datos)
  };
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página

  usuarior=false;
  claver=false;
  emplr=false;
  rolr=false;

  constructor(
    private service: AcceService,
    private router: Router,
    private elementRef: ElementRef,
    private PService: ParqServicesService,
    private imgbbService: ImgbbService
  ) {}

  ngOnInit(): void {
    this.cargarTodosLosDatos();
  }
  
  
  cargarTodosLosDatos(){
    this.service.getUsuarios().subscribe((data) => {
      this.usuario = data;
      this.usuariosFiltrados = data; 
      this.paginacionConfig.totalItems = this.usuario.length; 
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

  onChangeItemsPerPage(event: Event) {
    const selectedValue = (event.target as HTMLInputElement)?.value;
    if (selectedValue !== null) {
      const itemsPerPage = parseInt(selectedValue, 10);
      // Resto del código aquí
    }
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

  abririnsert(){
    this.usuarior=false;
    this.claver=false;
    this.emplr=false;
    this.rolr=false;
    this.InsertUsu = new Usuarios();
  }

  selectUsuario(usu: Usuarios) {
    usu.usua_Clave = '';
    this.usuarior=false;
    this.claver=false;
    this.emplr=false;
    this.rolr=false;
    this.selectedUsu = { ...usu };
  }

  selectUsuarioID(usu: Usuarios) {
    this.selectedUsu = { ...usu };
  }
  // !cargar datos al modal

  // CRUD
  Insert() {
    var campos = 0;

    if (!this.InsertUsu.usua_Img || this.InsertUsu.usua_Img.trim() === "") {this.InsertUsu.usua_Img = "../../assets/img/usuario.png";}
  
    if (!this.InsertUsu.usua_Usuario || this.InsertUsu.usua_Usuario.trim() === "") {this.usuarior=true;campos=+1}
    else{this.usuarior=false;}
  
    if (!this.InsertUsu.empl_Id || this.InsertUsu.empl_Id === 0) {this.emplr=true;campos=+1;}
    else{this.emplr=false;}
  
    if (!this.InsertUsu.usua_Clave || this.InsertUsu.usua_Clave.trim() === "") {this.claver=true;campos=+1}
    else{this.claver=false}
  
    if (!this.InsertUsu.usua_Admin && (!this.InsertUsu.role_ID || this.InsertUsu.role_ID === 0)) {this.rolr=true;campos=+1}
    else{this.rolr=false;}
  
    if (campos>0) {
    ToastUtils.showWarningToast("Hay Campos Vacios");
    return
    }

    this.service.InsertUsuario(this.InsertUsu).subscribe(
      (response: any) => {
        console.log(response);
        if ( response.code==200) {
          ToastUtils.showSuccessToast( response.message);
          setTimeout(() => {
            window.location.href = '/usuarios'
          }, 800);
          this.cargarTodosLosDatos();
        }
        if ( response.code==409) {
          ToastUtils.showWarningToast( response.message);   
        }
        if ( response.code==500) {
          ToastUtils.showErrorToast("Ha ocurrido un error inesperado");   
        }
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }
  
  

  Update() {
    var campos = 0;

    if (this.selectedUsu.usua_Img=="" || this.selectedUsu.usua_Img==null ||this.selectedUsu.usua_Img==undefined ) {
      this.selectedUsu.usua_Img="../../assets/img/usuario.png";
     }
     
    if (!this.selectedUsu.empl_Id || this.selectedUsu.empl_Id === 0) {this.emplr=true;campos=+1;}
    else{this.emplr=false;}

    if (!this.selectedUsu.usua_Admin && (!this.selectedUsu.role_ID|| this.selectedUsu.role_ID.toString()=="null" || this.selectedUsu.role_ID === 0)) {this.rolr=true;campos=+1; console.log("a")}
    else{this.rolr=false;}

     if (campos>0) {
      ToastUtils.showWarningToast("Hay Campos Vacios");
      return
      }
  
    this.service.UpdateUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);
        if ( response.code==200) {
          ToastUtils.showSuccessToast( response.message);
          setTimeout(() => {
            window.location.href = '/usuarios'
          }, 800);
          this.cargarTodosLosDatos();
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

  Delete() {
    this.service.DeleteUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        console.log(response);
        if ( response.code==200) {
          ToastUtils.showSuccessToast( response.message);
          this.cargarTodosLosDatos();
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

  Pass() {
    var campos = 0;
    if (!this.selectedUsu.usua_Clave || this.selectedUsu.usua_Clave.trim() === "") {this.claver=true;campos=+1;}
    else{this.claver=false}

    if (campos>0) {
      ToastUtils.showWarningToast("Hay Campos Vacios");
      return
      }

    this.service.PassUsuario(this.selectedUsu).subscribe(
      (response: any) => {
        ToastUtils.showSuccessToast( response.message);
        if ( response.code==200) {setTimeout(() => {
          window.location.href = '/usuarios'
        }, 800);
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
          this.InsertUsu.usua_Img = (this.imageUrl)
          this.selectedUsu.usua_Img=(this.imageUrl)
        },
        error => {
          // Manejar errores en la carga de la imagen
          console.error(error);
        }
      );
  }
  deleteImage() {
    this.imageUrl = "";
    this.InsertUsu.usua_Img="";
    this.selectedUsu.usua_Img="";
  }
  
  // !CRUD

}
