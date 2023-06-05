import { Component, OnInit } from '@angular/core';
import { HistorialVisitantesAtraccion, filterChartData } from '../Models/HistorialVisitantesAtraccion';
import { ParqServicesService } from '../ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { Color, colorSets } from '@swimlane/ngx-charts';
import { ToastUtils } from '../Utilities/ToastUtils';

@Component({
  selector: 'app-grafica',
  templateUrl: './grafica.component.html',
  styleUrls: ['./grafica.component.css'],
})
export class GraficaComponent implements OnInit{
  chartData!: HistorialVisitantesAtraccion[];
  sendParams: filterChartData = new filterChartData();
  initialDate: any;
  finalDate: any;
  data: {
    name: string,
    value: string,
  }[] = [];
  view: [number, number] = [1050, 500]; // Vista del gráfico
  colorScheme: string | Color = 'picnic'; 
  dateMessage = '';
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
  xAxisLabel = ''; // Etiqueta del eje X
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
    this.sendParams.fechaInicial = this.initialDate;
    this.sendParams.fechaFinal = this.finalDate;

    console.log(this.sendParams);
    this.service.getChartData(this.sendParams).subscribe((response : any) =>{
      console.log(response)
      if (response.success) {
        this.chartData = response.data;
        this.data = this.chartData.map(item => ({
          name: item.atra_Nombre.toString(),
          value: item.ticl_ID.toLocaleString()
        }));
      }
    })
  }

  validateFilterDates(){
    if(!this.initialDate && !this.finalDate ){
      ToastUtils.showWarningToast('Fechas de inicio y fin requeridas!.');
    }else if(!this.initialDate){
      ToastUtils.showWarningToast('');
    }
  }

  onDateChange(){
    this.dateMessage = '';
    this.xAxisLabel = '';
    if(this.initialDate && this.finalDate){
      this.getChartData();
      
      if(this.initialDate == this.finalDate){
        ToastUtils.showInfoToast('Aquí tienes los datos del '+ this.formatDateToWords(this.initialDate));      
        this.dateMessage = 'Mostrando datos del ' + this.formatDateToWords(this.initialDate);
        this.xAxisLabel = 'Atracciones más visitadas del ' + this.formatDateToWords(this.initialDate);

      }else{
        ToastUtils.showInfoToast('Aqui tienes los datos del '+ this.formatDateToWords(this.initialDate) + ' al ' +  this.formatDateToWords(this.finalDate));      
        this.dateMessage = 'Mostrando datos del ' + this.formatDateToWords(this.initialDate) + ' al ' +  this.formatDateToWords(this.finalDate);
        this.xAxisLabel = 'Atracciones más visitadas del ' + this.formatDateToWords(this.initialDate) + ' al ' +  this.formatDateToWords(this.finalDate);
      }
      
    }
  }

  formatDateToWords(dateString: string): string {
    const months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio',
      'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
  
    const parts = dateString.split('-');
    const year = Number(parts[0]);
    const monthIndex = Number(parts[1]) - 1;
    const day = Number(parts[2]);
  
    const month = months[monthIndex];
  
    return `${day} de ${month} de ${year}`;
  }
  
}
