import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http'
import { Cargos } from '../Models/Cargos';
import { Golosinas } from '../Models/Golosinas';
import { Atracciones } from '../Models/Atracciones';
import { VentasQuioscoDetalle } from '../Models/VentasQuioscoDetalle';
import { InsumosQuiosco } from '../Models/InsumosQuiosco';
import { ClientesRegistrados } from '../Models/ClientesRegistrados';
import { Empleados } from '../Models/Empleados';
import { ApiService } from '../api.service';

@Injectable({
  providedIn: 'root'
})
export class ParqServicesService {

  constructor(
    private http:HttpClient,
    private apiService: ApiService,
    ) { }



  // servicios de cargos //
  getCargos(){
    return this.http.get<Cargos[]>(this.apiService.apiUrl + '/Cargo/List');
  }

  createCargos(cargos: Cargos){
    return this.http.post<Cargos[]>(this.apiService.apiUrl + '/Cargo/Insert', cargos)
  }

  getCargosId(idcargo?: number){
    return this.http.get<Cargos>(this.apiService.apiUrl + '/Cargo/Find/'+ idcargo)
  }



  // servicios de golosinas //
  getGolosinas(){
    return this.http.get<Golosinas[]>(this.apiService.apiUrl + '/Golosinas/Listado');
  }

  // servicios de atracciones//
  getAtracciones(){
    return this.http.get<Atracciones[]>(this.apiService.apiUrl + '/Atracciones/List');
  }


  // servicios de quioscos//
  getInsumosQuiosco(){
    return this.http.get<InsumosQuiosco[]>(this.apiService.apiUrl + '/InsumosQuiosco/Listado');
  }


  // servicios de clientes registrados//
  getClientesRegistrados(){
    return this.http.get<ClientesRegistrados[]>(this.apiService.apiUrl + '/ClientesRegistrados/List');
  }


  // servicios de venta quiosco detalle//
  getVentasQuioscoDetalle(){
    return this.http.get<VentasQuioscoDetalle[]>(this.apiService.apiUrl + '/VentasQuioscoDetalle/Listado');
  }


  // servicios de Empleados //
  getEmpleados(){
    return this.http.get<Empleados[]>(this.apiService.apiUrl + '/Empleados/Listado')
  }

 
  // servicios de areas//
  getAreas(){
    return this.http.get
  }
}
