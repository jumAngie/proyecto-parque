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
      }
    });
  }
   
  checkZoomLevel() {
    var zoomLevel = Math.round(window.devicePixelRatio * 100);
  
    if (zoomLevel < 90) {
      // Mostrar el toast de recomendación
      ToastUtils.showInfoToast('Para un uso óptimo de los recursos de la aplicación, mantenga el zoom en 90%.');
    }
  }

  cargarAtracciones(AreaId: number){
    this.service.getAtraccionesPorId(AreaId)
    .subscribe((response: any) => {
      if (response.success) {
        console.log(response.data);
        this.atracciones = response.data;
      }
    });
  }
}
