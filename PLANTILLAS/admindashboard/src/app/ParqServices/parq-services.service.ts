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


  // servicios de cargos //
  getCargos(){
    return this.http.get<Cargos[]>(this.Url + 'Cargo/List');
  }

  createCargos(cargos: Cargos){
    return this.http.post<Cargos[]>(this.Url + 'Cargo/Insert', cargos)
  }

  getCargosId(idcargo?: number){
    return this.http.get<Cargos>(this.Url + 'Cargo/Find/'+ idcargo)
  }



  // servicios de golosinas //
  getGolosinas(){
    return this.http.get<Golosinas[]>(this.Url + 'Golosinas/Listado');
  }



  // servicios de Empleados //
  getEmpleados(){
    return this.http.get<Empleados[]>(this.Url + 'Empleados/Listado')
  }

 

}
