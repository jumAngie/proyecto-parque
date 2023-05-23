import { Component, OnInit } from '@angular/core';
import { Golosinas } from 'src/app/Models/Golosinas';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';

@Component({
  selector: 'app-listgolosinas',
  templateUrl: './listgolosinas.component.html',
  styleUrls: ['./listgolosinas.component.css']
})
export class ListgolosinasComponent implements OnInit {
  golosinas!: Golosinas[];
  colores: string[] = ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FF00FF'];
  emojis: string[] = ['😀', '😎', '🌟', '🐱', '🍕'];
  datos: any[] = [];

  constructor(private service:ParqServicesService) { }

  ngOnInit(): void {
  
    this.service.getGolosinas()
    .subscribe(data=>{
      this.golosinas = data;
    })
  }
}
