import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { VentasQuiosco } from 'src/app/Models/VentasQuiosco';
import { VentasQuioscoDetalle } from 'src/app/Models/VentasQuioscoDetalle';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';


@Component({
  selector: 'app-detalle',
  templateUrl: './detalle.component.html',
  styleUrls: ['./detalle.component.css']
})
export class VentasDetalleComponent implements OnInit{
  venta: VentasQuiosco = new VentasQuiosco();
  detalle!: VentasQuioscoDetalle[];
  totalRow: any = {};  

  filtro: String = '';
  p: number = 1;
  selectedPageSize = 5;
  pageSizeOptions: number[] = [5, 10 ,20, 30]; // Opciones de tamaño de página

  constructor(
    private service: ParqServicesService,
    private router: Router,
    
  ){}

  ngOnInit(): void {
    this.venta = JSON.parse(localStorage.getItem('venta') ?? '')
    this.getDetalles();
  };

  filtrarDetalles(): VentasQuioscoDetalle[]{
    const filtroLowerCase = this.filtro.toLowerCase();

    return this.detalle.filter(detalle => {
        const nombreValido = detalle.golo_Nombre.toLowerCase().includes(filtroLowerCase);
        const direccionValido = detalle.golo_Precio.toString().toLowerCase().includes(filtroLowerCase);
        const areaNombreValido = detalle.deta_Cantidad.toString().toLowerCase().includes(filtroLowerCase);
        const totalProds = detalle.valorFinalPorInsumo.toString().toLowerCase().includes(filtroLowerCase);
        return nombreValido || direccionValido || areaNombreValido || totalProds
    });
  };


  getDetalles(){
    this.service.getDetallesByVenta(this.venta.vent_ID).subscribe((response : any) =>{
      if(response.success){
        this.detalle = response.data;   

        for (let i = 0; i < this.detalle.length; i++) {
          const detalleItem = this.detalle[i];

          this.detalle.map(item =>{
            item.valorFinalPorInsumo = detalleItem.golo_Precio * detalleItem.deta_Cantidad;
          })
        };

        const Subtotal = this.detalle.reduce((total, detalleItem) => total + detalleItem.valorFinalPorInsumo, 0);
        const ISV = (Subtotal * 0.15).toFixed(2);
        const GranTotal = (parseFloat( Subtotal.toString()) + parseFloat(ISV.toString())).toFixed(2);

        this.totalRow = {
          vent_Subtotal: Subtotal,
          vent_ISV: ISV,
          vent_GranTotal: GranTotal,
        };
      };
    });
  };

  Volver(){
    this.router.navigate(['ventasquiosco-listado']);
  };
}
