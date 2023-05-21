import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AjaxResponse } from '../../interfaces/ajax';
import { chatHistory } from './message';

@Injectable()
export class QuickviewService {
  constructor(private http: HttpClient) {}

  // Get from the API
  getNotes() {
    return this.http.get<AjaxResponse<any>>('assets/data/notes.json')
  }

  getUsers() {
    return this.http.get<AjaxResponse<any>>('assets/data/users.json')
  }

  getChatMessages() {
    return this.http.get<AjaxResponse<any>>('assets/data/messages.json')
  }
}
