import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Categoria } from 'src/app/Models/Categoria';
import { Roles } from '../Models/Roles';
import { ApiService } from '../api.service';

@Injectable({
  providedIn: 'root'
})
export class AcceService {

  constructor(
      private http: HttpClient,
      private apiService: ApiService,
    ) { }
  Url = "Roles/Listado";
  UrlEdit= "Roles/Actualizar"


  getRoles(){
    return this.http.get<Roles[]>(this.apiService.apiUrl+this.Url);
    console.log(Roles)
  }

  EditarRol(rol: Roles) {
    return this.http.put(`${this.apiService.apiUrl}${this.UrlEdit}`, rol);
  }
}
