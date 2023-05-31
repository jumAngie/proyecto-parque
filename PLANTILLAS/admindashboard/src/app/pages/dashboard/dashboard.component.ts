import { Component, OnInit, ElementRef } from '@angular/core';
import { Areas } from 'src/app/Models/Areas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Atracciones } from 'src/app/Models/Atracciones';

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
  }

  cargarAreas() {
    this.service.getAreas().subscribe((response: any) => {
      if (response.success) {
        this.areas = response.data;
      }
    });
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
