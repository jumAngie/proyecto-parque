import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http'
import { Cargos } from '../Models/Cargos';
import { Golosinas } from '../Models/Golosinas';
import { Atracciones } from '../Models/Atracciones';
import { EstadosCiviles } from '../Models/EstadosCiviles';
import { VentasQuioscoDetalle } from '../Models/VentasQuioscoDetalle';
import { InsumosQuiosco } from '../Models/InsumosQuiosco';
import { ClientesRegistrados } from '../Models/ClientesRegistrados';
import { Empleados } from '../Models/Empleados';
import { ApiService } from '../api.service';
import { Areas } from '../Models/Areas';
import { Regiones } from '../Models/Regiones';
import { Quioscos } from '../Models/Quioscos';
import { AppComponent } from '../app.component';
import { VentasQuiosco } from '../Models/VentasQuiosco';
import { Pagos } from '../Models/Pagos';
import { Clientes } from '../Models/Clientes';
import { TicketsCliente } from '../Models/TicketsCliente';

@Injectable({
  providedIn: 'root'
})
export class ParqServicesService {

  constructor(
    private http:HttpClient,
    private apiService: ApiService,
    ) { }


  // servicios de estados civiles //

  getEstadoCivil(){
    return this.http.get<EstadosCiviles[]>(this.apiService.apiUrl + 'EstadosCiviles/Index');
  }

  // servicios de cargos //
  getCargos(){
    return this.http.get<Cargos[]>(this.apiService.apiUrl + 'Cargo/List');
  }

  createCargos(cargos: Cargos){
    return this.http.post<Cargos[]>(this.apiService.apiUrl + 'Cargo/Insert', cargos)
  }

  getCargosId(idcargo?: number){
    return this.http.get<Cargos>(this.apiService.apiUrl + 'Cargo/Find/'+ idcargo)
  }

  // servicios de golosinas //
  getGolosinas(){
    return this.http.get<Golosinas[]>(this.apiService.apiUrl + 'Golosinas/Listado');
  }


  // servicios de atracciones//
  getAtracciones(){
    return this.http.get<Atracciones[]>(this.apiService.apiUrl + 'Atracciones/List');
  }
  insertAtracciones(atracciones: Atracciones){
    return this.http.post<Atracciones[]>(this.apiService.apiUrl + 'Atracciones/Insert', atracciones);
  }
  findAtracciones(atracciones: Atracciones){
    return this.http.post<Atracciones[]>(this.apiService.apiUrl + 'Atracciones/Find', atracciones);
  }
  
  editAtracciones(atracciones: Atracciones){
    return this.http.put<Atracciones[]>(this.apiService.apiUrl + 'Atracciones/Update', atracciones);
  }
  deleteAtracciones(id: number){
    return this.http.post<Atracciones[]>(this.apiService.apiUrl + 'Atracciones/Delete/'+id, id);
  }
  
  getAtraccionesPorId(AreaId: number){
    return this.http.get<Atracciones[]>(this.apiService.apiUrl + '/Atracciones/FindArea/'+ AreaId)
  }


  // servicios de quioscos// 
  getQuioscos(){
    return this.http.get<Quioscos[]>(this.apiService.apiUrl + 'Quioscos/Listado');
  }
  getInsumosByQuisco(id: number){
    return this.http.post<InsumosQuiosco[]>(this.apiService.apiUrl + 'InsumosQuiosco/InsumosByQuiosco/'+id , id)
  }
  createQuioscos(quiosco: Quioscos){
    return this.http.post<Quioscos[]>(this.apiService.apiUrl + 'Quioscos/Insertar', quiosco)
  }
  findQuiosco(id: number){
    return this.http.post<Quioscos[]>(this.apiService.apiUrl + 'Quioscos/Find/'+ id, id);    
  }  
  updateQuiosco(quiosco: Quioscos){
    return this.http.post<Quioscos[]>(this.apiService.apiUrl + 'Quioscos/Actualizar', quiosco)
  }
  deleteQuiosco(id: number){
    return this.http.post<Quioscos[]>(this.apiService.apiUrl + 'Quioscos/Delete/'+id, id)
  }

  // servicios de insumos quioscos//
  getInsumosQuiosco(){
    return this.http.get<InsumosQuiosco[]>(this.apiService.apiUrl + 'InsumosQuiosco/Listado');
  }
  sendInsumos(insumo: InsumosQuiosco){
    return this.http.post<InsumosQuiosco[]>(this.apiService.apiUrl + 'InsumosQuiosco/Insertar', insumo);
  }


  //servicio  de clientes
  getClientes(){
    return this.http.get<Clientes[]>(this.apiService.apiUrl + 'Clientes/List');
  }

  
  // servicios de clientes registrados//
  getClientesRegistrados(){
    return this.http.get<ClientesRegistrados[]>(this.apiService.apiUrl + 'ClientesRegistrados/List');
  }


  // servicios de ventas por quiosco//
  getVentas(){
    return this.http.get<VentasQuiosco[]>(this.apiService.apiUrl + 'VentasQuiosco/Listado');
  }

  findVenta(id: number){
    return this.http.post<VentasQuiosco[]>(this.apiService.apiUrl + 'VentasQuiosco/Find/'+id, id);
  }

  getDetallesByVenta(id: number){
    return this.http.post<VentasQuioscoDetalle[]>(this.apiService.apiUrl + 'VentasQuioscoDetalle/DetallesPorVenta/'+id, id);
  }

  createVenta(venta: VentasQuiosco){
    return this.http.post<VentasQuiosco[]>(this.apiService.apiUrl + 'VentasQuiosco/Insertar', venta);
  }

  createVentaDetalle(detalle: VentasQuioscoDetalle){
    return this.http.post<VentasQuioscoDetalle[]>(this.apiService.apiUrl + 'VentasQuioscoDetalle/Insertar', detalle);
  }

  deleteInsumo(detalle: VentasQuioscoDetalle){
    return this.http.post<VentasQuioscoDetalle[]>(this.apiService.apiUrl + 'VentasQuioscoDetalle/EliminarInsumo', detalle);
  }

  closeReceipt(id: number){
    return this.http.post<VentasQuiosco[]>(this.apiService.apiUrl + ''+id, id);
  }

  // Servicio de Pagos
  getPagos(){
    return this.http.get<Pagos[]>(this.apiService.apiUrl + 'VentasQuiosco/ListadoMetodosPago');
  }



  // servicios de Empleados //
  getEmpleados(){
    return this.http.get<Empleados[]>(this.apiService.apiUrl + 'Empleados/Listado')
  }

  insertEmpleados(empleados: Empleados){
    return this.http.post<Empleados[]>(this.apiService.apiUrl + 'Empleados/Insertar', empleados)
  }

  getEmpleadosId(idEmpleado?: number){
    return this.http.get<Empleados>(this.apiService.apiUrl + 'Empleados/Find/'+ idEmpleado)
  }

  deleteEmpleado(idEmpleado?: string){
    return this.http.post<Empleados[]>(this.apiService.apiUrl + 'Empleados/Delete/' + idEmpleado, idEmpleado)
  }

  editEmpleados(empleados: Empleados){
    return this.http.post<Empleados[]>(this.apiService.apiUrl + 'Empleados/Actualizar', empleados)
  }
 
  // servicios de areas//
  getAreas(){
    return this.http.get<Areas[]>(this.apiService.apiUrl + 'Areas/List');
  }



  // servicios de regiones//
  getRegiones(){
    return this.http.get<Regiones[]>(this.apiService.apiUrl + 'Regiones/List')
  }

  // servicios de tickets cliente //
  getTicketsCliente(){
    return this.http.get<TicketsCliente[]>(this.apiService.apiUrl + 'TicketClientes/List')
  }
}
