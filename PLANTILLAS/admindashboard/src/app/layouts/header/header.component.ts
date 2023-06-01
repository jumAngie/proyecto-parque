import { Component, OnInit, Inject } from '@angular/core';
import { DOCUMENT } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
  usua_Usuario = localStorage.getItem("usua_Usuario");
  nombreEmpleado = localStorage.getItem("nombreEmpleado");
  usua_Img = localStorage.getItem("usua_Img");
  
  constructor(@Inject(DOCUMENT) private document: Document, private router:Router) { }

  ngOnInit(): void {
  }
  sidebarToggle()
  {

    //toggle sidebar function
    this.document.body.classList.toggle('toggle-sidebar');
  }

  DashBoard(){
    this.router.navigate(['dashboard'])
  }

  Log_Out(){
    localStorage.clear()
    window.location.href = '/'; 
  }
}
