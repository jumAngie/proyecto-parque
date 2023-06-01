import { Component, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent implements OnInit {
  acce: any[] = [];
  quioscos: any[] = [];
  fila: any[] = [];
  parq: any[] = [];
  generales: any[] = [];
  reportes: any[] = [];





  constructor(private service: AcceService, private router: Router) {}

  ngOnInit(): void {
    const id: string | null = localStorage.getItem("usua_ID");
    if (id==null) {
      this.router.navigate(['/']);
    }

    // Convertir id a número o usar 0 si es nulo
    const parsedId: number = id !== null ? parseInt(id) : 0;

    this.service.MenuID(parsedId).subscribe(
      (response: any) => {
        this.acce = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'ACCE');
        this.quioscos = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'QUIO');
        this.fila = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'FILA');
        this.parq = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'PARQ');
        this.generales = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'GRAL');
        this.reportes = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'REPO');

      },
      (error: any) => {
        console.error('Error:', error);
      }
    );
  }
}
