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
  categoria: Categoria = new Categoria();

  constructor (private service: ServiceService, private router: Router){}

  Guardar(){
    this.service.createCategoria(this.categoria)
    .subscribe(data => {
      alert("Se agregó con éxito la categoria");
      this.router.navigate(['index']);
      console.log(data);
    })
  }
}
