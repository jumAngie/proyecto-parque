import { Component, OnInit, ElementRef } from '@angular/core';
import { Areas } from 'src/app/Models/Areas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Atracciones } from 'src/app/Models/Atracciones';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements OnInit {
  areas!: Areas[];
  atracciones!: Atracciones[];
  atraccionesPorArea: {[key: string]: any[]} = {};
  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef
  ) {}
  ngOnInit(): void {
    this.cargarAreas();
    window.addEventListener('resize', this.checkZoomLevel.bind(this));
  }
  
  cargarAreas() {
    this.service.getAreas().subscribe((response: any) => {
      if (response.success) {
        this.areas = response.data;
        console.log(response.data);
        this.areas.forEach((area) => {
          this.cargarAtracciones(area.area_ID);
        });
      }
    });
  }
  
  cargarAtracciones(AreaId: any) {
    this.service.getAtraccionesPorId(AreaId)
      .subscribe((response: any) => {
        if (response.success) {
          const area = this.areas.find((item) => item.area_ID === AreaId);
          if (area) {
            if (!this.atraccionesPorArea[AreaId]) {
              this.atraccionesPorArea[AreaId] = [];
            }
            this.atraccionesPorArea[AreaId] = response.data;
            console.log(this.atraccionesPorArea);
          }
        }
      });
  }
  

  detailAtraccion(atracciones: Atracciones){
    localStorage.setItem('atra_Detail_ID', atracciones.atra_ID?.toString());
    this.router.navigate(['atracciones-detalle']);
  }
  
  
   
  checkZoomLevel() {
    var zoomLevel = Math.round(window.devicePixelRatio * 100);
    if (zoomLevel < 90) {
      // Mostrar el toast de recomendación
      ToastUtils.showInfoToast('Para un uso óptimo de los recursos de la aplicación, mantenga el zoom en 90%.');
    }
  }

}
