import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';


@Component({
  selector: 'app-detail',
  templateUrl: './detail.component.html',
  styleUrls: ['./detail.component.css']
})
export class AtraccionesDetailComponent implements OnInit{
  atracciones: Atracciones = new Atracciones();
  requestData: Atracciones = new Atracciones();

  constructor(
    private service: ParqServicesService,
    private router: Router,

  ){}

  ngOnInit(): void {
    
    this.getAtraccionesDetail();
  }

  getAtraccionesDetail(){
    this.requestData.atra_ID = parseInt( localStorage.getItem('atra_Detail_ID')?.toString() ?? '')
    this.service.findAtracciones(this.requestData).subscribe((response : any) =>{
      console.log(response);
      if (response.success) {
        this.atracciones = response.data[0];
      }
    })
  };

  Volver(){
    this.router.navigate(['atracciones-listado']);
  }
}
