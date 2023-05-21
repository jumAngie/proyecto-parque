import { Component, OnInit, Input, ViewEncapsulation } from '@angular/core';

import {
  animate,
  state,
  style,
  transition,
  trigger
} from '@angular/animations';

import { SocialService } from './social.service';
import { NgxMasonryOptions } from 'ngx-masonry';
declare var stepsForm: any;
declare var pg: any;

// import { IsotopeOptions } from 'ngx-isotope';

@Component({
  selector: 'app-social',
  templateUrl: './social.component.html',
  styleUrls: ['./social.component.scss'],
  encapsulation: ViewEncapsulation.None,
  animations: [
    trigger('enterAnimation', [
      state(
        'loading',
        style({
          opacity: '0',
          transform: 'translateY(8%)'
        })
      ),
      state(
        'ready',
        style({
          opacity: '1',
          transform: 'translateY(0)'
        })
      ),
      transition(
        'loading => ready',
        animate('300ms cubic-bezier(0.1, 0.0, 0.2, 1)')
      )
    ])
  ]
})
export class SocialComponent implements OnInit {
  feed;
  //   _isLoading: boolean = true;
  _mode: boolean = true;

  constructor(private _service: SocialService) {}

  public myOptions: NgxMasonryOptions = {
    horizontalOrder: true,
    gutter: 5
  };

  @Input()
  set mode(value) {
    this._mode = value;
  }

  ngOnInit() {
    this._service.getFeed().subscribe(items => {
      this.feed = items;
      console.log(this.feed);
    });
    // Retrieve posts from the API
    // this._service.getFeed().subscribe(feed => {
    //   this.feed = feed.result;
    //   console.log(feed)
    // //   setTimeout(() => {
    // //     this._isLoading = false;
    // //   }, 2000);
    // });
  }

  // public myOptions: IsotopeOptions = {
  //   itemSelector: '.card',
  //   masonry: {
  //     columnWidth: 300,
  //     gutter: 20,
  //     fitWidth: true
  //   }
  // };
}
