import { Component, ElementRef, Input, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-pages-login',
  templateUrl: './pages-login.component.html',
  styleUrls: ['./pages-login.component.css']
})
export class PagesLoginComponent implements OnInit {

   username = "";
   password = "";
   
  constructor(private service: AcceService, private router: Router, private elementRef: ElementRef) {}

  ngOnInit(): void {
  }

  Login() {
    this.service.login(this.username, this.password).subscribe(
      (response: any) => {
        console.log(response);
        if (response.usua_ID!=0) {
          localStorage.setItem("usua_ID",response.usua_ID);
          localStorage.setItem("usua_Usuario",response.usua_Usuario);
          localStorage.setItem("nombreEmpleado",response.nombreEmpleado);


          console.log(localStorage.getItem("usua_ID"));
          this.router.navigate(['/dashboard']);
        }

      },
      (error: any) => {
        console.error('Error >', error);
      }
    );
  }
  
  
}

