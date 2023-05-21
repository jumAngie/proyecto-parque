import { Routes } from '@angular/router';
//Layouts
import { 
  CondensedComponent,
  BlankComponent,
  CorporateLayout,
  SimplyWhiteLayout,
  ExecutiveLayout,
  CasualLayout ,
  BlankCasualComponent,
  BlankCorporateComponent,
  BlankSimplywhiteComponent
} from './@pages/layouts';


export const AppRoutes: Routes = [

  {
    path: '',
    data: {
        breadcrumb: 'Home'
    },
    component: CondensedComponent
  },
  {
    path: 'casual',
    component: CasualLayout
  },
  {
    path: 'executive',
    component: ExecutiveLayout
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout
  },
  {
    path: 'corporate',
    component: CorporateLayout
  },
];
