import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http'
import { Categoria } from '../Model/Categoria';

@Injectable({
  providedIn: 'root'
})
export class ServiceService {

  constructor(private http: HttpClient) { }
  Url = "http://serviciospublicitarios.somee.com/api/Categoria/Listado";

  getCategoria(){
    return this.http.get<Categoria[]>(this.Url);
  }

  UrlCreate = "http://serviciospublicitarios.somee.com/api/Categoria/Insertar";

  createCategoria(categoria: Categoria){
    return this.http.post<Categoria[]>(this.UrlCreate, categoria);    
  }

  UrlEdit = "http://serviciospublicitarios.somee.com/api/Categoria/Buscar?id=";
  findCategoria(id?: number){
    return this.http.get<Categoria[]>(this.UrlEdit+id);
  }
}
