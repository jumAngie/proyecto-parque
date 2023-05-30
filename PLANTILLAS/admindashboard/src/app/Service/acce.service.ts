import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Categoria } from 'src/app/Models/Categoria';
import { Roles } from '../Models/Roles';
import { ApiService } from '../api.service';
import { Pantallas } from '../Models/Pantallas';
import { Usuarios } from '../Models/Usuarios';

@Injectable({
  providedIn: 'root'
})
export class AcceService {

  constructor(
      private http: HttpClient,
      private apiService: ApiService,
    ) { }

  Url                   =  "Roles/Listado";
  UrlGetUsuarios        =  "Usuarios/Listado";
  UrlInsert             =  "Roles/Insertar"
  UrlUpdate             =  "Roles/Actualizar"
  UrlEliminar           =  "Roles/Eliminar?id="
  Pantallas             =  "Pantallas/Index"
  PantallasAgg          =  "Pantallas/PantallasAgg"
  PantallasElim         =  "Pantallas/PantallasElim"
  PantallasCheck        =  "Pantallas/PantallasPorRol_Checked"
  Login                 =  "Usuarios/Login"
  UrlInsertUsuario      =  "Usuarios/Insertar"
  UrlUpdateUsuario      =  "Usuarios/Actualizar"
  UrlDeleteUsuario      =  "Usuarios/Eliminar?id="
  UrlPassUsuario        =  "Usuarios/Pass"
  Menu                  =  "Usuarios/Menu?id="
  DeletePantallas       =  "Pantallas/PantallasEliminado?pr="

  

  getRoles(){
    return this.http.get<Roles[]>(this.apiService.apiUrl+this.Url);
  }

  getPantallas(){
    return this.http.get<Pantallas[]>(this.apiService.apiUrl+this.Pantallas);
  }

  InsertRoles(rol: Roles){
    return this.http.post(`${this.apiService.apiUrl}${this.UrlInsert}`, rol);
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

  
  RolPantPantallasEliminado(rol: number) {
    const url = `${this.apiService.apiUrl}${this.DeletePantallas}${rol}`;
    console.log(url)
    return this.http.post(url, null);
  }

  RolPantCK(rol: Roles) {
    return this.http.post(`${this.apiService.apiUrl}${this.PantallasCheck}`, rol);
  }

  login(username: string, password: string) {
    
    return this.http.get(`${this.apiService.apiUrl}${this.Login}`, {
      params: {
        username: username,
        password: password
      }
    });
  }
  

  //Usuarios
  getUsuarios(){
    return this.http.get<Usuarios[]>(this.apiService.apiUrl+this.UrlGetUsuarios);
  }
  
  InsertUsuario(usuario: Usuarios){
    return this.http.post(`${this.apiService.apiUrl}${this.UrlInsertUsuario}`, usuario);
  }

  UpdateUsuario(usuario:Usuarios){
    return this.http.put(`${this.apiService.apiUrl}${this.UrlUpdateUsuario}`, usuario);
  }

  PassUsuario(usuario:Usuarios){
    return this.http.put(`${this.apiService.apiUrl}${this.UrlPassUsuario}`, usuario);
  }

  DeleteUsuario(usuario:Usuarios){
    const url = `${this.apiService.apiUrl}${this.UrlDeleteUsuario}${usuario.usua_ID}`;
    return this.http.put(url, null);
  }

  MenuID(id:number){
    const url = `${this.apiService.apiUrl}${this.Menu}${id}`;
    return this.http.get(url);
  }
}
