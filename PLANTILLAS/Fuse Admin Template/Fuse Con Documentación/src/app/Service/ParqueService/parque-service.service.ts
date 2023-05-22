import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Atracciones } from 'app/Model/Atracciones';

@Injectable({
  providedIn: 'root'
})
export class ParqueServiceService {

  constructor(private http: HttpClient) { }
  Url = "https://localhost:44322/api/Atracciones/List";

  getAtracciones(){
    return this.http.get<Atracciones[]>(this.Url);
  }
}
