import { Component, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';
import { Roles } from 'src/app/Models/Roles';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss']
})
export class IndexComponent implements OnInit {
  rol: Roles[] = [];
  p: number = 1;
  filtro: string = '';

  constructor(private service: AcceService, private router: Router) { }

  ngOnInit(): void {
    this.service.getRoles().subscribe(data => {
      this.rol = data;
      console.log(data);
    });
  }

  filtrarRoles(): Roles[] {
    return this.rol.filter(rol => {
      return rol.role_Nombre.toLowerCase().includes(this.filtro.toLowerCase());
    });
  }
}
