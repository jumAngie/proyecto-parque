import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Categoria } from 'src/app/Models/Categoria';
import { Roles } from '../Models/Roles';
import { ApiService } from '../api.service';
import { Pantallas } from '../Models/Pantallas';

@Injectable({
  providedIn: 'root'
})
export class AcceService {

  constructor(
      private http: HttpClient,
      private apiService: ApiService,
    ) { }
  Url = "Roles/Listado";
  UrlInsert = "Roles/Insertar"
  UrlUpdate = "Roles/Actualizar"
  UrlEliminar = "Roles/Eliminar?id="
  Pantallas =  "Pantallas/Index"
  PantallasAgg =  "Pantallas/PantallasAgg"
  PantallasElim =  "Pantallas/PantallasElim"
  PantallasCheck =  "Pantallas/PantallasPorRol_Checked"



  getRoles(){
    return this.http.get<Roles[]>(this.apiService.apiUrl+this.Url);
    console.log(Roles)
  }

  getPantallas(){
    return this.http.get<Pantallas[]>(this.apiService.apiUrl+this.Pantallas);
    console.log(Roles)
  }

  InsertRoles(rol: Roles){
    return this.http.post(`${this.apiService.apiUrl}${this.UrlInsert}`, rol);
    console.log(Roles)
  }

  EditarRol(rol: Roles) {
    return this.http.put(`${this.apiService.apiUrl}${this.UrlUpdate}`, rol);
  }

  DeleteRol(rol: Roles) {
    const url = `${this.apiService.apiUrl}${this.UrlEliminar}${rol.role_Id}`;
    console.log(url)
    return this.http.put(url, null);
  }
  
  
  RolPantAgg(pantalla: Pantallas) {
    return this.http.post(`${this.apiService.apiUrl}${this.PantallasAgg}`, pantalla);
  }

  
  RolPantPantallasElim(pantalla: Pantallas) {
    return this.http.post(`${this.apiService.apiUrl}${this.PantallasElim}`, pantalla);
  }

  RolPantCK(rol: Roles) {
    return this.http.post(`${this.apiService.apiUrl}${this.PantallasCheck}`, rol);
  }
}
