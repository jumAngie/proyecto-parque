import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http'
import { Cargos } from '../Models/Cargos';
import { Golosinas } from '../Models/Golosinas';
import { Atracciones } from '../Models/Atracciones';
import { VentasQuioscoDetalle } from '../Models/VentasQuioscoDetalle';
import { InsumosQuiosco } from '../Models/InsumosQuiosco';
import { ClientesRegistrados } from '../Models/ClientesRegistrados';
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

  getAtracciones(){
    return this.http.get<Atracciones[]>(this.Url + 'Atracciones/List');
  }

  getInsumosQuiosco(){
    return this.http.get<InsumosQuiosco[]>(this.Url + 'InsumosQuiosco/Listado');
  }

  getClientesRegistrados(){
    return this.http.get<ClientesRegistrados[]>(this.Url + 'ClientesRegistrados/List');
  }

  getVentasQuioscoDetalle(){
    return this.http.get<VentasQuioscoDetalle[]>(this.Url + 'VentasQuioscoDetalle/Listado');
  }


  // servicios de Empleados //
  getEmpleados(){
    return this.http.get<Empleados[]>(this.Url + 'Empleados/Listado')
  }

 

}
