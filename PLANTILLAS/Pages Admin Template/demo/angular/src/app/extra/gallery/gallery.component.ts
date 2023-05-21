import {
  Component,
  OnInit,
  ViewChild,
  ViewChildren,
  QueryList
} from '@angular/core';
import {
  animate,
  state,
  style,
  transition,
  trigger
} from '@angular/animations';

import { GalleryService } from './gallery.service';

@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.scss'],
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
export class GalleryComponent implements OnInit {
  feed;
  service;
  _isLoading: boolean = true;
  constructor(private _service: GalleryService) {}

  @ViewChild('slider') public _slider: any;
  @ViewChild('fadInModal', { static: true }) _modal: any;

  config;
  configModal;
  index = 0;
  index2 = 0;
  //   _isLoading: boolean = true;
  rangeValue;
  public slides = [
    'https://picsum.photos/700/250/?image=27',
    'https://picsum.photos/700/250/?image=22',
    'https://picsum.photos/700/250/?image=61',
    'https://picsum.photos/700/250/?image=23',
    'https://picsum.photos/700/250/?image=24',
    'https://picsum.photos/700/250/?image=26',
    'https://picsum.photos/700/250/?image=41',
    'https://picsum.photos/700/250/?image=28',
    'https://picsum.photos/700/250/?image=21',
    'https://picsum.photos/700/250/?image=20',
    'https://picsum.photos/400/250/?image=75'
  ];

  //   public configModal = {
  //     a11y: true,
  //     direction: 'horizontal',
  //     navigation: {
  //       nextEl: '.carousel__arrow--prev',
  //       prevEl: '.carousel__arrow--next',
  //     },
  //     breakpoints: {
  //       // when window width is <= 1024px
  //       1024: {
  //         slidesPerView: 5.5,
  //       },
  //     },
  //   };

  ngOnInit() {
    this.service = this._service.getFeed().subscribe(data => {
      this.feed = data;
      console.log(this.feed);
    });

    // this.config = {
    //   init: false,
    //   observer: true,
    //   direction: 'vertical',
    //   autoplay: {
    //     delay: 5000
    //   }
    // };

    this.configModal = {
      //   autoplay: {
      //     delay: 5000,
      //   },
      a11y: true,
      direction: 'horizontal',
      observer: true,
      spaceBetween: 10,
      slideToClickedSlide: true,
      slidesPerView: 4.5,
      slidesOffsetBefore: 20,
      slidesOffsetAfter: 20,
      simulateTouch: true,
      resistanceRatio: 0.6,
      watchSlidesVisibility: true,
      watchSlidesProgress: true,
      watchOverflow: true,
      navigation: {
        nextEl: '.carousel__arrow--prev',
        prevEl: '.carousel__arrow--next'
      },
      breakpoints: {
        // when window width is <= 1024px
        1024: {
          slidesPerView: 5.5
        }
      }
    };
  }

  public onIndexChange(index: number): void {
    console.log('Swiper index: ', index);
  }

  public onSwiperEvent(event: string): void {
    console.log('Swiper event: ', event);
  }

  toggleModal() {
    this._modal.show();
  }
}
