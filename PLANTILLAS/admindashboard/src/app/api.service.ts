import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  apiUrl = 'http://www.parqueatracciones.somee.com/api/'; 

  constructor() { }
}
