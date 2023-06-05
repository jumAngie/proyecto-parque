import { Component, OnInit, ElementRef, Renderer2 } from '@angular/core';
import { Empleados } from 'src/app/Models/Empleados';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { ImgbbService } from 'src/app/Service_IMG/imgbb-service.service';

@Component({
  selector: 'app-listempleados',
  templateUrl: './listempleados.component.html',
  styleUrls: ['./listempleados.component.scss']
})
export class ListempleadosComponent implements OnInit {
  empleados!: Empleados[];
  filtro: string = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página

  showModalD=false;
  idEmpleado!: number;
  constructor(
    private service:ParqServicesService, 
    private elementRef: ElementRef, 
    private router:Router,
    private renderer2: Renderer2,
    private imgbbService: ImgbbService,
    ) { }


  ngOnInit(): void {
    this.empleadosList();
  }

  empleadosList(){
    this.service.getEmpleados()
    .subscribe((response: any) => {
      if (response.success) {
        this.empleados = response.data;
      }
    });
  }

  filtrarEmpleados(): Empleados[] {
    const filtroLowerCase = this.filtro.toLowerCase();
  
    return this.empleados.filter(empleado => {
      const nombreValido = empleado.empl_NombreCompleto.toLowerCase().includes(filtroLowerCase);
      const estadoCivilValido = empleado.civi_Descripcion.toLowerCase().includes(filtroLowerCase);
      const dniValido = empleado.empl_DNI.toString().includes(this.filtro);
      const telefonoValido = empleado.empl_Telefono.toString().includes(this.filtro);
  
      return nombreValido || estadoCivilValido || dniValido || telefonoValido;
    });
  }

  detailEmpleados(empleados: Empleados){
    localStorage.setItem('empleado_Detail_Id', empleados.empl_ID?.toString());
    this.router.navigate(['detallempleados']);
  }

  Editar(empleados: Empleados){
    localStorage.setItem('idEmpleado', empleados.empl_ID.toString());
    console.log(localStorage.getItem('idEmpleado'));
    this.router.navigate(['editarempleados']);
  }

  



  
  //#region   MODAL DELETE
    onDelete(id: number){
      this.idEmpleado = id;
      this.openDeleteModal();
    }

    openDeleteModal() {
      const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
      this.renderer2.setStyle(modalDelete, 'display', 'block');
      setTimeout(() => {
        this.renderer2.addClass(modalDelete, 'show');
        this.showModalD = true;
      }, 0);
    }

    closeDeleteModal() {
      const modalDelete = this.elementRef.nativeElement.querySelector('#modalDelete');
      this.renderer2.removeClass(modalDelete, 'show');
      setTimeout(() => {
        this.renderer2.setStyle(modalDelete, 'display', 'none');
        this.showModalD = false;
      }, 300); // Ajusta el tiempo para que coincida con la duración de la transición en CSS
    }

    Eliminar() {

      if (this.idEmpleado) {
        this.service.deleteEmpleado(this.idEmpleado.toString())
          .subscribe((response: any) => {
            if (response.code == 200) {
              ToastUtils.showSuccessToast(response.message);
              localStorage.setItem('idEmpleadosEliminar', '');
              this.empleadosList();
            } else {
              ToastUtils.showErrorToast(response.message);
            }
            this.closeDeleteModal();
          });
      }
    }
  //#endregion


}