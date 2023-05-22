import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Categoria } from 'app/Model/Categoria';

@Injectable({
  providedIn: 'root'
})

export class AcceService {

  constructor(private http: HttpClient) { }
  Url = "https://api.thecatapi.com/v1/categories";

  getCategoria(){
    return this.http.get<Categoria[]>(this.Url);
  }
}
