import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http'
import { Cargos } from '../Models/Cargos';
import { Golosinas } from '../Models/Golosinas';
import { Empleados } from '../Models/Empleados';


@Injectable({
  providedIn: 'root'
})
export class ParqServicesService {

  constructor(private http:HttpClient) { }

  Url="https://localhost:44322/api/";

  getCargos(){
    return this.http.get<Cargos[]>(this.Url + 'Cargo/List');
  }

  getGolosinas(){
    return this.http.get<Golosinas[]>(this.Url + 'Golosinas/Listado');
  }

  getEmpleados(){
    return this.http.get<Empleados[]>(this.Url + 'Empleados/Listado')
  }

}
