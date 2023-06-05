import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { AlertsComponent } from './components/alerts/alerts.component';
import { AccordionComponent } from './components/accordion/accordion.component';
import { BadgesComponent } from './components/badges/badges.component';
import { BreadcrumbsComponent } from './components/breadcrumbs/breadcrumbs.component';
import { ButtonsComponent } from './components/buttons/buttons.component';
import { CardsComponent } from './components/cards/cards.component';
import { CarouselComponent } from './components/carousel/carousel.component';
import { ChartsApexchartsComponent } from './components/charts-apexcharts/charts-apexcharts.component';
import { ChartsChartjsComponent } from './components/charts-chartjs/charts-chartjs.component';
import { FormsEditorsComponent } from './components/forms-editors/forms-editors.component';
import { FormsElementsComponent } from './components/forms-elements/forms-elements.component';
import { FormsLayoutsComponent } from './components/forms-layouts/forms-layouts.component';
import { IconsBootstrapComponent } from './components/icons-bootstrap/icons-bootstrap.component';
import { IconsBoxiconsComponent } from './components/icons-boxicons/icons-boxicons.component';
import { IconsRemixComponent } from './components/icons-remix/icons-remix.component';
import { ListGroupComponent } from './components/list-group/list-group.component';
import { ModalComponent } from './components/modal/modal.component';
import { PaginationComponent } from './components/pagination/pagination.component';
import { ProgressComponent } from './components/progress/progress.component';
import { SpinnersComponent } from './components/spinners/spinners.component';
import { TablesDataComponent } from './components/tables-data/tables-data.component';
import { TablesGeneralComponent } from './components/tables-general/tables-general.component';
import { TabsComponent } from './components/tabs/tabs.component';
import { TooltipsComponent } from './components/tooltips/tooltips.component';
import { PagesBlankComponent } from './pages/pages-blank/pages-blank.component';
import { PagesContactComponent } from './pages/pages-contact/pages-contact.component';
import { PagesError404Component } from './pages/pages-error404/pages-error404.component';
import { PagesFaqComponent } from './pages/pages-faq/pages-faq.component';
import { PagesLoginComponent } from './pages/pages-login/pages-login.component';

import { PagesLoginCComponent } from './pages/pages-login-c/pages-login-c.component';


import { PagesRegisterComponent } from './pages/pages-register/pages-register.component';
import { UsersProfileComponent } from './pages/users-profile/users-profile.component';


//Cargos
import { ListcargosComponent } from './Cargos/listcargos/listcargos.component';
import { CreatecargosComponent } from './Cargos/createcargos/createcargos.component';
import { EditarcargosComponent } from './Cargos/editarcargos/editarcargos.component';

//Golosinas
import { ListgolosinasComponent } from './Golosinas/listgolosinas/listgolosinas.component';

//Quioscos
import { ListarquioscosComponent } from './Quioscos/listarquioscos/listarquioscos.component';
import { DetalleQuioscoComponent } from './Quioscos/detalle/detalle.component';
import { EditQuioscoComponent } from './Quioscos/edit/edit.component';
import { CreateQuioscoComponent } from './Quioscos/create/create.component';

//Atracciones
import { ListAtraccionesComponent } from './Atracciones/list/list.component';
import { CreateAtraccionesComponent } from './Atracciones/create/create.component';
import { EditAtraccionesComponent } from './Atracciones/edit/edit.component';
import { AtraccionesDetailComponent } from './Atracciones/detail/detail.component';

//Insumos
import { ListInsumosQuioscoComponent } from './InsumosQuiosco/list/list.component';

//Clientes
import { ListClientesRegistradosComponent } from './ClientesRegistrados/list/list.component';

// Ventas quiosco
import { VentasListComponent } from './VentasQuioscoDetalle/list/list.component';
import { VentasCrearComponent } from './VentasQuioscoDetalle/create/create.component';
import { VentasDetalleComponent } from './VentasQuioscoDetalle/detalle/detalle.component';


//Empleados
import { ListempleadosComponent } from './Empleados/listempleados/listempleados.component';
import { CrearempleadosComponent } from './Empleados/crearempleados/crearempleados.component';
import { EditarempleadosComponent } from './Empleados/editarempleados/editarempleados.component';

//Roles
import { IndexComponent } from './Roles/index/index.component';

//Login
import {LoginComponent} from '../app/login/login.component'

//Grafica
import { GraficaComponent } from './grafica/grafica.component';

import { UsuariosComponent } from './usuarios/usuarios.component';

import { CreateticketsclienteComponent } from './TicketsCliente/createticketscliente/createticketscliente.component';
import { ListticketsclienteComponent } from './TicketsCliente/listticketscliente/listticketscliente.component';

import { CreateticketsComponent } from './Tickets/createtickets/createtickets.component';
import { ListticketsComponent } from './Tickets/listtickets/listtickets.component';
import { DetallesempleadosComponent } from './Empleados/detallesempleados/detallesempleados.component';

import { FilasListadoComponent } from './Filas/filas-listado/filas-listado.component';
import { TemporizadoresListadoComponent } from './Filas/temporizadores-listado/temporizadores-listado.component';

import { ReporteComponent } from './reporte/reporte.component';
const routes: Routes = [
  { path: 'dashboard', component: DashboardComponent },
  { path: 'alerts', component: AlertsComponent },
  { path: 'accordion', component: AccordionComponent },

  { path: 'roles', component: IndexComponent },
  { path: 'filas', component: FilasListadoComponent },
  { path: 'temporizadores', component: TemporizadoresListadoComponent },
  { path: 'usuarios', component: UsuariosComponent },
  
  { path: 'badges', component: BadgesComponent },
  { path: 'breadcrumbs', component: BreadcrumbsComponent },
  { path: 'buttons', component: ButtonsComponent },
  { path: 'cards', component: CardsComponent },
  { path: 'carousel', component: CarouselComponent },
  { path: 'charts-apexcharts', component: ChartsApexchartsComponent },
  { path: 'charts-chartjs', component: ChartsChartjsComponent },
  { path: 'form-editors', component: FormsEditorsComponent },
  { path: 'form-elements', component: FormsElementsComponent },
  { path: 'form-layouts', component: FormsLayoutsComponent },
  { path: 'icons-bootstrap', component: IconsBootstrapComponent },
  { path: 'icons-boxicons', component: IconsBoxiconsComponent },
  { path: 'icons-remix', component: IconsRemixComponent },
  { path: 'list-group', component: ListGroupComponent },
  { path: 'modal', component: ModalComponent },
  { path: 'pagination', component: PaginationComponent },
  { path: 'progress', component: ProgressComponent },
  { path: 'spinners', component: SpinnersComponent },
  { path: 'tables-data', component: TablesDataComponent },
  { path: 'tables-general', component: TablesGeneralComponent },
  { path: 'tabs', component: TabsComponent },
  { path: 'tooltips', component: TooltipsComponent },
  { path: 'pages-blank', component: PagesBlankComponent },
  { path: 'pages-contact', component: PagesContactComponent },
  { path: 'pages-error404', component: PagesError404Component },
  { path: 'pages-faq', component: PagesFaqComponent },
  { path: 'pages-login', component: PagesLoginComponent },

  { path: 'pages-login-c', component: PagesLoginCComponent },
  
  { path: '', redirectTo: 'pages-login', pathMatch: 'full' },
  { path: 'pages-register', component: PagesRegisterComponent },
  { path: 'user-profile', component: UsersProfileComponent },

  //Cargos
  { path: 'listcargos', component: ListcargosComponent},
  {path: 'createcargos', component: CreatecargosComponent},
  {path: 'editarcargos', component: EditarcargosComponent},

  //Golosinas
  { path: 'listgolosinas', component: ListgolosinasComponent},
  
  //Atracciones
  { path: 'atracciones-listado', component: ListAtraccionesComponent},
  { path: 'atracciones-crear', component: CreateAtraccionesComponent},
  { path: 'atracciones-editar', component: EditAtraccionesComponent},
  { path: 'atracciones-detalle', component: AtraccionesDetailComponent  },

  //Insumos
  { path: 'listinsumosquiosco', component: ListInsumosQuioscoComponent},

  //Clientes
  { path: 'listclientesregistrados', component: ListClientesRegistradosComponent},

  //Ventas quiosco detalle
  {path: 'ventasquiosco-listado', component: VentasListComponent},
  {path: 'ventasquiosco-crear', component: VentasCrearComponent},
  {path: 'ventasquiosco-detalle', component: VentasDetalleComponent},

  //Empleados
  {path: 'listempleados', component: ListempleadosComponent},
  {path: 'crearempleados', component: CrearempleadosComponent},
  {path: 'editarempleados', component: EditarempleadosComponent},
  {path: 'detallempleados', component: DetallesempleadosComponent},
  
  //Quioscos
  {path: 'quioscos-listado', component: ListarquioscosComponent},
  {path: 'quioscos-detalle', component: DetalleQuioscoComponent},
  {path: 'quioscos-crear', component: CreateQuioscoComponent},
  {path: 'quioscos-editar', component: EditQuioscoComponent},

  {path: 'createcargos', component: CreatecargosComponent},
  {path: 'editarcargos', component: EditarcargosComponent},

  {path: 'listticketsclientes', component: ListticketsclienteComponent},
  {path: 'createticketsclientes', component:CreateticketsclienteComponent},

  {path: 'listtitckets', component:ListticketsComponent},
  {path: 'createtickets', component:CreateticketsComponent},

  {path: 'grafica', component: GraficaComponent},
  {path: 'reporte', component: ReporteComponent},

];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { onSameUrlNavigation: 'reload' })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
