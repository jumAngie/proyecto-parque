import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/Model/Categoria';
import { ServiceService } from 'src/app/Service/service.service';

@Component({
  selector: 'app-crear',
  templateUrl: './crear.component.html',
  styleUrls: ['./crear.component.css']
})
export class CrearComponent {

  categorianew:Categoria = new Categoria();
  constructor (private service: ServiceService, private router: Router){}

  Guardar(){
    this.service.createCategoria()
    .subscribe(data=>{
      alert("Se agregó con exito")
    })
  }
}
