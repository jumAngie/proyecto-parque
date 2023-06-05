import { Component, ElementRef, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listarclientes',
  templateUrl: './listarclientes.component.html',
  styleUrls: ['./listarclientes.component.css']
})
export class ListarclientesComponent {
  filtro: String = '';
  p: number = 1;
  selectedPageSize = 2;
  pageSizeOptions: number[] = [2, 4 ,6, 8]; // Opciones de tamaño de página

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef
  ) { }


}
