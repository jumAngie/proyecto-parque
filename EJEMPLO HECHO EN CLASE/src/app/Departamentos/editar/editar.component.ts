import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/Model/Categoria';
import { ServiceService } from 'src/app/Service/service.service';

@Component({
  selector: 'app-editar',
  templateUrl: './editar.component.html',
  styleUrls: ['./editar.component.css']
})
export class EditarComponent {
  categoria:Categoria = new Categoria();

  constructor (private service: ServiceService, private router: Router){}

  ngOnInit(): void {
    this.Editar();
    
  }

  Editar(){
    this.service
  }

}
