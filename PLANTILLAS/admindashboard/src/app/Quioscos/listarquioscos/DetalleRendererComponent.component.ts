import { Component, Input, OnInit } from '@angular/core';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
@Component({
  selector: 'app-detalle-renderer',
  template: `
    <div *ngIf="detalleData">
      <!-- Mostrar los detalles del quiosco aquí -->
      <p>{{ detalleData.quio_ID }}</p>
      <p>{{ detalleData.quio_Nombre }}</p>
    </div>
  `,
})
export class DetalleRendererComponent implements OnInit {
  @Input() quio_ID: number | undefined;
  detalleData: any;

  constructor(private service: ParqServicesService) {}

  ngOnInit(): void {
    if (this.quio_ID) {
      this.getDetalleQuiosco(this.quio_ID);
    }
  }

  getDetalleQuiosco(quio_ID: number): void {
    this.service.getInsumos(quio_ID).subscribe((response: any) => {
      if (response.success) {
        this.detalleData = response.data;
      }
    });
  }
}
