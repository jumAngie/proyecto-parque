import { Component, OnInit, ElementRef, Renderer2 } from '@angular/core';
import { Router, TitleStrategy } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';
import { VentasQuiosco } from 'src/app/Models/VentasQuiosco';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})

export class VentasListComponent implements OnInit {
  ventas!: VentasQuiosco[];
  ventasQuioscoDetalle!: VentasQuioscoDetalle[];
  deleteID: any;

  filtro: String = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página


  constructor(
    private service: ParqServicesService, 
    private router: Router
  ) { }

  ngOnInit(): void {

    this.getVentas();
  }


  
  filtrarVentas(){
    const filtroLowerCase = this.filtro.toLowerCase();

    return this.ventas.filter(venta => {
      const ventaID = venta.vent_ID.toString().toLowerCase().includes(filtroLowerCase);
      const pagoNomrbe = venta.pago_Nombre.toLowerCase().includes(filtroLowerCase);
      const fecha = venta.vent_FechaCreacion.toString().toLowerCase().includes(filtroLowerCase);
      const nombres = venta.clie_Nombres.toLowerCase().includes(filtroLowerCase);
      const apellidos = venta.clie_Apellidos.toLowerCase().includes(filtroLowerCase);
      return ventaID || pagoNomrbe || fecha || nombres || apellidos
    })
  }

  getVentas(){
    this.service.getVentas()
    .subscribe((response: any) => {
      console.log(response);
      if(response.success){
        this.ventas = response.data;
      }
    })
  }


  Agregar(){
    this.router.navigate(['ventasquiosco-crear']);
  };

  onDetail(rowData: any): void{    
    localStorage.setItem('venta', JSON.stringify(rowData));    
    this.router.navigate(['ventasquiosco-detalle']);
  }

  onEdit(rowData: any): void {
     ToastUtils.showErrorToast('Esta factura ya ha sido finalizada, imposible editar.')
  }
  
  onDelete(rowData: any): void {
    ToastUtils.showErrorToast('Esta factura ya ha sido finalizada, imposible eliminar')
  }
}
