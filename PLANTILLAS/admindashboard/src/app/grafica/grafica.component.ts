import { Component } from '@angular/core';


@Component({
  selector: 'app-grafica',
  templateUrl: './grafica.component.html',
  styleUrls: ['./grafica.component.css'],
  template: `
  <ngx-charts-bar-vertical
    [view]="view"
    [scheme]="colorScheme"
    [results]="single"
    [gradient]="gradient"
    [xAxis]="showXAxis"
    [yAxis]="showYAxis"
    [legend]="showLegend"
    [showXAxisLabel]="showXAxisLabel"
    [showYAxisLabel]="showYAxisLabel"
    [xAxisLabel]="xAxisLabel"
    [yAxisLabel]="yAxisLabel">
  </ngx-charts-bar-vertical>
`,  
})
export class GraficaComponent {
  
}
