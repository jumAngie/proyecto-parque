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

  constructor(private service: AcceService, private router: Router) {}

  ngOnInit(): void {
    const id: string | null = localStorage.getItem("usua_ID");
    console.log(id);

    // Convertir id a número o usar 0 si es nulo
    const parsedId: number = id !== null ? parseInt(id) : 0;

    this.service.MenuID(parsedId).subscribe(
      (response: any) => {
        this.acce = response.filter((item: { pant_Identificador: string; }) => item.pant_Identificador === 'ACCE');
      },
      (error: any) => {
        console.error('Error:', error);
      }
    );
  }
}
