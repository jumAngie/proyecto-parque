import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AjaxResponse } from '@pages/interfaces/ajax';

@Injectable()
export class EmailServiceLight {
  constructor(private http: HttpClient) {}

  // Get all emails from the API
  getEmails() {
    return this.http.get<AjaxResponse<any>>('assets/data/email.json')
  }
}
