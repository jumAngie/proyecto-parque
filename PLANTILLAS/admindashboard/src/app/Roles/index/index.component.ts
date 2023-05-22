import { Component, OnInit, AfterViewInit } from '@angular/core';
import * as $ from 'jquery';
import 'datatables.net';

import { Categoria } from 'src/app/Models/Categoria';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss']
})
export class IndexComponent implements OnInit {
  categoria!: Categoria[]
  p: number = 1;

  constructor (private service: AcceService, private router: Router){}

  ngOnInit(): void {
    //Called after the constructor, initializing input properties, and the first call to ngOnChanges.
    //Add 'implements OnInit' to the class.
    
    this.service.getCategoria()
    .subscribe(data =>{
      this.categoria = data;
      console.log(data);
    })
  }
}
