import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RouterModule } from '@angular/router';
import { HeaderComponent } from './layouts/header/header.component';
import { FooterComponent } from './layouts/footer/footer.component';
import { SidebarComponent } from './layouts/sidebar/sidebar.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { AlertsComponent } from './components/alerts/alerts.component';
import { AccordionComponent } from './components/accordion/accordion.component';
import { BadgesComponent } from './components/badges/badges.component';
import { BreadcrumbsComponent } from './components/breadcrumbs/breadcrumbs.component';
import { ButtonsComponent } from './components/buttons/buttons.component';
import { CardsComponent } from './components/cards/cards.component';
import { CarouselComponent } from './components/carousel/carousel.component';
import { ListGroupComponent } from './components/list-group/list-group.component';
import { ModalComponent } from './components/modal/modal.component';
import { PaginationComponent } from './components/pagination/pagination.component';
import { ProgressComponent } from './components/progress/progress.component';
import { SpinnersComponent } from './components/spinners/spinners.component';
import { TooltipsComponent } from './components/tooltips/tooltips.component';
import { FormsElementsComponent } from './components/forms-elements/forms-elements.component';
import { FormsLayoutsComponent } from './components/forms-layouts/forms-layouts.component';
import { FormsEditorsComponent } from './components/forms-editors/forms-editors.component';
import { TablesGeneralComponent } from './components/tables-general/tables-general.component';
import { TablesDataComponent } from './components/tables-data/tables-data.component';
import { ChartsChartjsComponent } from './components/charts-chartjs/charts-chartjs.component';
import { ChartsApexchartsComponent } from './components/charts-apexcharts/charts-apexcharts.component';
import { IconsBootstrapComponent } from './components/icons-bootstrap/icons-bootstrap.component';
import { IconsRemixComponent } from './components/icons-remix/icons-remix.component';
import { IconsBoxiconsComponent } from './components/icons-boxicons/icons-boxicons.component';
import { UsersProfileComponent } from './pages/users-profile/users-profile.component';
import { PagesFaqComponent } from './pages/pages-faq/pages-faq.component';
import { PagesContactComponent } from './pages/pages-contact/pages-contact.component';
import { PagesRegisterComponent } from './pages/pages-register/pages-register.component';
import { PagesLoginComponent } from './pages/pages-login/pages-login.component';
import { PagesError404Component } from './pages/pages-error404/pages-error404.component';
import { PagesBlankComponent } from './pages/pages-blank/pages-blank.component';
import { HttpClient, HttpClientModule } from '@angular/common/http';

import { ListcargosComponent } from './Cargos/listcargos/listcargos.component';
import { ListgolosinasComponent } from './Golosinas/listgolosinas/listgolosinas.component';
import { ListAtraccionesComponent } from './Atracciones/list/list.component';
import { ListInsumosQuioscoComponent } from './InsumosQuiosco/list/list.component';
import { ListClientesRegistradosComponent } from './ClientesRegistrados/list/list.component';


import { ListempleadosComponent } from './Empleados/listempleados/listempleados.component';
import { EditarempleadosComponent } from './Empleados/editarempleados/editarempleados.component';

import { CreatecargosComponent } from './Cargos/createcargos/createcargos.component';
import { EditarcargosComponent } from './Cargos/editarcargos/editarcargos.component'
import { IndexComponent } from './Roles/index/index.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { CreateAtraccionesComponent } from './Atracciones/create/create.component';
import { TabsComponent } from '../app/tabs/tabs.component';
import { ParqServicesService } from './ParqServices/parq-services.service';
import { CrearempleadosComponent } from './Empleados/crearempleados/crearempleados.component';
import { EditAtraccionesComponent } from './Atracciones/edit/edit.component';
  

import { NgbAlertModule, NgbNavModule } from '@ng-bootstrap/ng-bootstrap';
import { NgIf } from '@angular/common';
import { NgSelectModule } from '@ng-select/ng-select';
import { LoginComponent } from './login/login.component';
import { AgGridModule } from 'ag-grid-angular';
import { ListarquioscosComponent } from './Quioscos/listarquioscos/listarquioscos.component';

import { DetallesempleadosComponent } from './Empleados/detallesempleados/detallesempleados.component';
import { ListticketsComponent } from './Tickets/listtickets/listtickets.component';
import { CreateticketsComponent } from './Tickets/createtickets/createtickets.component';
import { ListticketsclienteComponent } from './TicketsCliente/listticketscliente/listticketscliente.component';
import { CreateticketsclienteComponent } from './TicketsCliente/createticketscliente/createticketscliente.component';

import { DetalleQuioscoComponent } from './Quioscos/detalle/detalle.component';
import { EditQuioscoComponent } from './Quioscos/edit/edit.component';
import { CreateQuioscoComponent } from './Quioscos/create/create.component';

import { VentasCrearComponent } from './VentasQuioscoDetalle/create/create.component';

import { VentasListComponent } from './VentasQuioscoDetalle/list/list.component';


import { UsuariosComponent } from './usuarios/usuarios.component';

import { PagesLoginCComponent } from './pages/pages-login-c/pages-login-c.component';
import { VentasDetalleComponent } from './VentasQuioscoDetalle/detalle/detalle.component';
import { AtraccionesDetailComponent } from './Atracciones/detail/detail.component';
import { GraficaComponent } from './grafica/grafica.component';
import { NgxChartsModule } from '@swimlane/ngx-charts';
import { MapComponent } from './map/map.component';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatStepperModule } from '@angular/material/stepper';
import { MatButtonModule } from '@angular/material/button';

import { FilasListadoComponent } from './Filas/filas-listado/filas-listado.component';
import { TemporizadoresListadoComponent } from './Filas/temporizadores-listado/temporizadores-listado.component';
import { ReporteComponent } from './reporte/reporte.component';

@NgModule({
  declarations: [
    AppComponent,
    IndexComponent,
    TabsComponent,
    HeaderComponent,
    FooterComponent,
    SidebarComponent,
    DashboardComponent,
    AlertsComponent,
    AccordionComponent,
    BadgesComponent,
    BreadcrumbsComponent,
    ButtonsComponent,
    CardsComponent,
    CarouselComponent,
    ListGroupComponent,
    ModalComponent,
    TabsComponent,
    PaginationComponent,
    ProgressComponent,
    SpinnersComponent,
    TooltipsComponent,
    FormsElementsComponent,
    FormsLayoutsComponent,
    FormsEditorsComponent,
    TablesGeneralComponent,
    TablesDataComponent,
    ChartsChartjsComponent,
    ChartsApexchartsComponent,
    IconsBootstrapComponent,
    IconsRemixComponent,
    IconsBoxiconsComponent,
    UsersProfileComponent,
    PagesFaqComponent,
    PagesContactComponent,
    PagesRegisterComponent,
    PagesLoginComponent,
    PagesError404Component,
    PagesBlankComponent,
    ListcargosComponent,
    ListgolosinasComponent,
    ListAtraccionesComponent,
    ListClientesRegistradosComponent,
    ListInsumosQuioscoComponent,

    ListempleadosComponent,
    CreatecargosComponent,
    EditarcargosComponent,
    CreateAtraccionesComponent,
    LoginComponent,
    UsuariosComponent,
    CrearempleadosComponent,
    EditAtraccionesComponent,
    LoginComponent,
    EditarempleadosComponent,
    ListarquioscosComponent,
    DetalleQuioscoComponent,
    EditQuioscoComponent,
    CreateQuioscoComponent,
    VentasListComponent,
    VentasCrearComponent,
    VentasDetalleComponent,

    DetallesempleadosComponent,
    PagesLoginCComponent,
    ListticketsComponent,
    CreateticketsComponent,
    ListticketsclienteComponent,
    CreateticketsclienteComponent,
    AtraccionesDetailComponent,
    GraficaComponent,
    MapComponent,
    FilasListadoComponent,
    TemporizadoresListadoComponent,
    ReporteComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    RouterModule,
    NgxPaginationModule,
    NgbNavModule,
    NgIf,
    NgbAlertModule,
    NgSelectModule,
    AgGridModule,
    NgxChartsModule,
    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    MatStepperModule,
    MatButtonModule    
  ],
  providers: [ParqServicesService],
  bootstrap: [AppComponent]
})
export class AppModule { }
