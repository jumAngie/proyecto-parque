import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Categoria } from 'src/app/Models/Categoria';
import { Roles } from '../Models/Roles';

@Injectable({
  providedIn: 'root'
})
export class AcceService {

  constructor(private http: HttpClient) { }
  Url = "https://localhost:44322/api/Roles/Listado";

  getRoles(){
    return this.http.get<Roles[]>(this.Url);
    console.log(Roles)
  }
}
