import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  apiUrl = 'https://localhost:44322/api/'; // Establece aquí la URL base de tu API

  constructor() { }
}
