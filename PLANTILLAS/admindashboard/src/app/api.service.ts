import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  //apiUrl = 'http://parqueatracciones2.somee.com/api/'; 
  apiUrl = 'https://localhost:44322/api/'; 

  constructor() { }
}
