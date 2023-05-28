import { Component, ElementRef, Input, OnInit } from '@angular/core';
import { AcceService } from 'src/app/Service/acce.service';
import { Router } from '@angular/router';
import { Roles } from 'src/app/Models/Roles';
import { FormBuilder, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { Pantallas } from 'src/app/Models/Pantallas';
import { NgbNavChangeEvent } from '@ng-bootstrap/ng-bootstrap';

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
    console.log("sepa la vrg la mera vrd");
    console.log(this.username , this.password);
    this.service.login(this.username, this.password).subscribe(
      (response: any) => {
        console.log(response);
        if (response.usua_ID!=0) {
          this.router.navigate(['/dashboard']);
        }

      },
      (error: any) => {
        console.error('Error >', error);
      }
    );
  }
  
  
}

