import { Component, OnInit } from '@angular/core';
import { InsumosQuiosco } from 'src/app/Models/InsumosQuiosco';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListInsumosQuioscoComponent implements OnInit {
  insumosQuiosco!: InsumosQuiosco[];

  constructor(
    private service: ParqServicesService, 
    private router: Router    
  ) { };

  ngOnInit(): void {
    this.service.getInsumosQuiosco()
    .subscribe((response: any) => {
      if(response.success){
        this.insumosQuiosco = response.data;
        console.log(response.data);
      }
    })
  }

};
