import { Component, OnInit } from '@angular/core';
import { Golosinas } from 'src/app/Models/Golosinas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listgolosinas',
  templateUrl: './listgolosinas.component.html',
  styleUrls: ['./listgolosinas.component.scss']
})
export class ListgolosinasComponent implements OnInit {
  golosinas!: Golosinas[];
  p: number = 1;
  filtro: string = '';

  constructor(private service:ParqServicesService) { }

  ngOnInit(): void {
  
    this.service.getGolosinas()
    .subscribe(data=>{
      this.golosinas = data;
    })
  }

  filtrarGolosinas(): Golosinas[] {
    const filtroLowerCase = this.filtro.toLowerCase();
  
    return this.golosinas.filter(golosinas => {
      const nombreValido = golosinas.golo_Nombre.toLowerCase().includes(filtroLowerCase);
      const idValido = golosinas.golo_ID.toString().includes(this.filtro);
      const precioValido = golosinas.golo_Precio.toString().includes(this.filtro);
  
      return nombreValido || idValido || precioValido;
    });
  }
}
