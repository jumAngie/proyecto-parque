import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AjaxResponse } from '@pages/interfaces/ajax';

@Injectable()
export class IconsService {
  constructor(private http: HttpClient) {}

  // Get all posts from the API
  getFontAwesome() {
    return this.http.get<AjaxResponse<any>>('assets/data/fontawesome.json');
  }
}
