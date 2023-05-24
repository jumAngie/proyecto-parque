import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListAtraccionesComponent implements OnInit {
  atracciones!: Atracciones[];
  p: number = 1;
  filtro: string = '';
  constructor(
    private service: ParqServicesService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.service.getAtracciones()
      .subscribe((response: any) => {
        if (response.success) {
          this.atracciones = response.data;
        }
      });
  }

  filtrarAtracciones(): Atracciones[] {
    return this.atracciones.filter(atracciones => {
      return atracciones.atra_Nombre.toLowerCase().includes(this.filtro.toLowerCase());
    });
  }

  AgregarAtraccion(){
    this.router.navigate(['crearatracciones'])
  }

}
