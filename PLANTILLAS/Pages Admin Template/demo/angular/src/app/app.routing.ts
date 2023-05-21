import { Routes } from '@angular/router';
//Layouts
import {
  CondensedComponent,
  BlankComponent,
  CorporateLayout,
  SimplyWhiteLayout,
  ExecutiveLayout,
  CasualLayout,
  BlankCasualComponent,
  BlankCorporateComponent,
  BlankSimplywhiteComponent,
  DemoComponent
} from '@pages/layouts';

//Sample Pages
import { CondensedDashboardComponent } from './dashboard/condensed/dashboard.component';
import { SimplyWhiteDashboardComponent } from './dashboard/simplywhite/dashboard.component';
import { CasualDashboardComponent } from './dashboard/casual/dashboard.component';
import { CorporateDashboardComponent } from './dashboard/corporate/dashboard.component';
import { ExecutiveDashboardComponent } from './dashboard/executive/dashboard.component';
import { CardsComponentPage } from './cards/cards.component';
import { ViewsPageComponent } from './views/views.component';
import { ChartsComponent } from './charts/charts.component';
import { SocialComponent } from './social/social.component';

export const AppRoutes: Routes = [
  {
    path: '',
    data: {
      breadcrumb: 'Home'
    },
    component: DemoComponent
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'dashboard',
        component: CondensedDashboardComponent
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'extra',
        loadChildren: () => import('./extra/extra.module').then(m => m.ExtraModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'layouts',
        loadChildren: () => import('./layouts/layouts.module').then(m => m.LayoutPageModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: BlankComponent,
    children: [
      {
        path: 'session',
        loadChildren: () => import('./session/session.module').then(m => m.SessionModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'forms',
        loadChildren: () => import('./forms/forms.module').then(m => m.FormsPageModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'builder',
        loadChildren: () => import('./builder/builder.module').then(m => m.BuilderModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'ui',
        loadChildren: () => import('./ui/ui.module').then(m => m.UiModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'email',
        loadChildren: () => import('./email/email.module').then(m => m.EmailModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'social',
        component: SocialComponent
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'cards',
        component: CardsComponentPage
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'views',
        component: ViewsPageComponent
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'maps',
        loadChildren: () => import('./maps/maps.module').then(m => m.MapsModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'tables',
        loadChildren: () => import('./tables/tables.module').then(m => m.TablesModule)
      }
    ]
  },
  {
    path: 'condensed',
    component: CondensedComponent,
    children: [
      {
        path: 'charts',
        component: ChartsComponent
      }
    ]
  },
  //Corporate Layout Styles and Routing
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'dashboard',
        component: CorporateDashboardComponent
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'extra',
        loadChildren: () => import('./extra/extra.module').then(m => m.ExtraModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: BlankCorporateComponent,
    children: [
      {
        path: 'session',
        loadChildren: () => import('./session/session.module').then(m => m.SessionModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'social',
        component: SocialComponent
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'forms',
        loadChildren: () => import('./forms/forms.module').then(m => m.FormsPageModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'layouts',
        loadChildren: () => import('./layouts/layouts.module').then(m => m.LayoutPageModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'builder',
        loadChildren: () => import('./builder/builder.module').then(m => m.BuilderModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'ui',
        loadChildren: () => import('./ui/ui.module').then(m => m.UiModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'email',
        loadChildren: () => import('./email/email.module').then(m => m.EmailModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'cards',
        component: CardsComponentPage
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'views',
        component: ViewsPageComponent
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'tables',
        loadChildren: () => import('./tables/tables.module').then(m => m.TablesModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'maps',
        loadChildren: () => import('./maps/maps.module').then(m => m.MapsModule)
      }
    ]
  },
  {
    path: 'corporate',
    component: CorporateLayout,
    children: [
      {
        path: 'charts',
        component: ChartsComponent
      }
    ]
  },
  //Simply White Routes
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'dashboard',
        component: SimplyWhiteDashboardComponent
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'extra',
        loadChildren: () => import('./extra/extra.module').then(m => m.ExtraModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: BlankSimplywhiteComponent,
    children: [
      {
        path: 'session',
        loadChildren: () => import('./session/session.module').then(m => m.SessionModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'social',
        component: SocialComponent
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'forms',
        loadChildren: () => import('./forms/forms.module').then(m => m.FormsPageModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'layouts',
        loadChildren: () => import('./layouts/layouts.module').then(m => m.LayoutPageModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'builder',
        loadChildren: () => import('./builder/builder.module').then(m => m.BuilderModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'ui',
        loadChildren: () => import('./ui/ui.module').then(m => m.UiModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'email',
        loadChildren: () => import('./email-light/email.module').then(m => m.EmailLightModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'cards',
        component: CardsComponentPage
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'views',
        component: ViewsPageComponent
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'tables',
        loadChildren: () => import('./tables/tables.module').then(m => m.TablesModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'maps',
        loadChildren: () => import('./maps/maps.module').then(m => m.MapsModule)
      }
    ]
  },
  {
    path: 'simplywhite',
    component: SimplyWhiteLayout,
    children: [
      {
        path: 'charts',
        component: ChartsComponent
      }
    ]
  },
  //Executive
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'dashboard',
        component: ExecutiveDashboardComponent,
        data: {
          title: 'dashboard'
        }
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'social',
        component: SocialComponent,
        data: {
          title: 'social'
        }
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'extra',
        loadChildren: () => import('./extra/extra.module').then(m => m.ExtraModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'layouts',
        loadChildren: () => import('./layouts/layouts.module').then(m => m.LayoutPageModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'builder',
        loadChildren: () => import('./builder/builder.module').then(m => m.BuilderModule)
      }
    ]
  },
  {
    path: 'executive',
    component: BlankComponent,
    children: [
      {
        path: 'session',
        loadChildren: () => import('./session/session.module').then(m => m.SessionModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'forms',
        loadChildren: () => import('./forms/forms.module').then(m => m.FormsPageModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'ui',
        loadChildren: () => import('./ui/ui.module').then(m => m.UiModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'email',
        loadChildren: () => import('./email/email.module').then(m => m.EmailModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'cards',
        component: CardsComponentPage,
        data: {
          title: 'cards'
        }
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'views',
        component: ViewsPageComponent,
        data: {
          title: 'views'
        }
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'tables',
        loadChildren: () => import('./tables/tables.module').then(m => m.TablesModule)
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'maps',
        loadChildren: () => import('./maps/maps.module').then(m => m.MapsModule),
        data: {
          title: 'maps'
        }
      }
    ]
  },
  {
    path: 'executive',
    component: ExecutiveLayout,
    children: [
      {
        path: 'charts',
        component: ChartsComponent,
        data: {
          title: 'charts'
        }
      }
    ]
  },
  //Casual
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'dashboard',
        component: CasualDashboardComponent
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'social',
        component: SocialComponent
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'builder',
        loadChildren: () => import('./builder/builder.module').then(m => m.BuilderModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'layouts',
        loadChildren: () => import('./layouts/layouts.module').then(m => m.LayoutPageModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'extra',
        loadChildren: () => import('./extra/extra.module').then(m => m.ExtraModule)
      }
    ]
  },
  {
    path: 'casual',
    component: BlankCasualComponent,
    children: [
      {
        path: 'session',
        loadChildren: () => import('./session/session.module').then(m => m.SessionModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'forms',
        loadChildren: () => import('./forms/forms.module').then(m => m.FormsPageModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'ui',
        loadChildren: () => import('./ui/ui.module').then(m => m.UiModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'email',
        loadChildren: () => import('./email/email.module').then(m => m.EmailModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'cards',
        component: CardsComponentPage
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'views',
        component: ViewsPageComponent
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'tables',
        loadChildren: () => import('./tables/tables.module').then(m => m.TablesModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'maps',
        loadChildren: () => import('./maps/maps.module').then(m => m.MapsModule)
      }
    ]
  },
  {
    path: 'casual',
    component: CasualLayout,
    children: [
      {
        path: 'charts',
        component: ChartsComponent
      }
    ]
  }
];
