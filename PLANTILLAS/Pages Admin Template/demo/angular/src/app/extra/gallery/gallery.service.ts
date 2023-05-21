import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AjaxResponse } from '@pages/interfaces/ajax';

@Injectable()
export class GalleryService {
  constructor(private http: HttpClient) {}

  // Get social feed posts
  getFeed() {
    return this.http.get<AjaxResponse<any>>('assets/data/gallery.json')
  }
}
