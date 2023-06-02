import { Component, OnInit } from '@angular/core';
import { HistorialVisitantesAtraccion } from '../Models/HistorialVisitantesAtraccion';
import { ParqServicesService } from '../ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Color, colorSets } from '@swimlane/ngx-charts';
import { ToastUtils } from '../Utilities/ToastUtils';

@Component({
  selector: 'app-grafica',
  templateUrl: './grafica.component.html',
  template: `
<ngx-charts-bar-vertical
  [view]="view"
  [scheme]="colorScheme"
  [results]="data"
  [gradient]="gradient"
  [xAxis]="showXAxis"
  [yAxis]="showYAxis"
  [legend]="showLegend"
  [legendTitle]="leyendTitle"
  [showXAxisLabel]="showXAxisLabel"
  [showYAxisLabel]="showYAxisLabel"
  [xAxisLabel]="xAxisLabel"
  [yAxisLabel]="yAxisLabel"
  [animations]="animations"
  [showDataLabel]="showDataLabel"
  [roundDomains]="roundDomains"
  [dataLabelFormatting]="valueFormatting"  
  >
</ngx-charts-bar-vertical>
`,
})
export class GraficaComponent implements OnInit{
  chartData!: HistorialVisitantesAtraccion[];
  sendParams: HistorialVisitantesAtraccion = new HistorialVisitantesAtraccion();
  initialDate: any;
  finalDate: any;
  data: {
    name: string,
    value: string,
  }[] = [];
  view: [number, number] = [800, 500]; // Vista del gráfico
  colorScheme: string | Color = 'picnic'; 

  /* 
  COLOR SCHEMES:{
    vivid
    natural
    cool
    fire
    solar
    air 
    aqua
    flame
    ocean
    forest
    horizon
    neons
    picnic
    night
    nightLights
  }
*/


  gradient = false; // Opcional: si deseas utilizar gradientes en el gráfico
  showXAxis = true; // Mostrar eje X
  showYAxis = true; // Mostrar eje Y
  showLegend = true; // Mostrar leyenda
  leyendTitle = 'Atracciones';
  showXAxisLabel = true; // Mostrar etiqueta del eje X
  showYAxisLabel = true; // Mostrar etiqueta del eje Y
  xAxisLabel = 'Atracciones más visitadas del dia'; // Etiqueta del eje X
  yAxisLabel = 'Cantidad de personas'; // Etiqueta del eje Y
  animations = true;
  showDataLabel = true;
  roundDomains = true;
  wrapTicks = true;
  barPadding = 20;
  valueFormatting = (value: number) => `${value.toLocaleString()}`;  
  
  constructor(
    private service: ParqServicesService,
    private router: Router,
    
  ){    
  }

  ngOnInit(): void {
    this.getChartData();
  }

  getChartData(){
    this.sendParams.initalDate = this.initialDate;
    this.sendParams.finalDate = this.finalDate;

    console.log(this.sendParams);
    // this.service.getChartData(this.sendParams).subscribe((response : any) =>{
    //   console.log(response)
    //   if (response.success) {
    //     this.chartData = response.data;
    //     this.data = this.chartData.map(item => ({
    //       name: item.atra_Nombre.toString(),
    //       value: item.ticl_ID.toLocaleString()
    //     }));
    //   }
    // })
  }

  validateFilterDates(){
    if(!this.initialDate && !this.finalDate ){
      ToastUtils.showWarningToast('Fechas de inicio y fin requeridas!.');
    }else if(!this.initialDate){
      ToastUtils.showWarningToast('');
    }
  }

  validateFinalDate(){

  }

  onDateChange(){
    this.getChartData();
  }
}
