import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ListarComponent } from './Departamentos/listar/listar.component';
import { CrearComponent } from './Departamentos/crear/crear.component';
import {HttpClientModule} from '@angular/common/http'
import {FormsModule} from "@angular/forms";
import { EditarComponent } from './Departamentos/editar/editar.component'

@NgModule({
  declarations: [
    AppComponent,
    ListarComponent,
    CrearComponent,
    EditarComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
