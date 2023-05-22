import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/Model/Categoria';
import { ServiceService } from 'src/app/Service/service.service';

@Component({
  selector: 'app-listar',
  templateUrl: './listar.component.html',
  styleUrls: ['./listar.component.css']
})
export class ListarComponent {
  categoria!: Categoria[]

  constructor (private service: ServiceService, private router: Router){}

  ngOnInit(): void {
    //Called after the constructor, initializing input properties, and the first call to ngOnChanges.
    //Add 'implements OnInit' to the class.
    
    this.service.getCategoria()
    .subscribe((response: any) =>{
      if(response.success){
        this.categoria = response.data;
        console.log(response.data);
      }
    })
  }

  Editar(categoriaEdit: Categoria): void{
    localStorage.setItem('id', categoriaEdit.cate_Id?.toString());
    this.router.navigate(['editar'])
  }
}
