import { Component, OnInit, OnDestroy, ViewEncapsulation } from '@angular/core';
declare var pg: any;

//import echarts
import { EChartsOption } from 'echarts';

@Component({
  selector: 'stacked-bar-widget',
  templateUrl: './stacked-bar-widget.component.html',
  styleUrls: ['./stacked-bar-widget.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class StackedBarWidgetComponent implements OnInit, OnDestroy {

	chartOption: EChartsOption = {
		tooltip: {
			backgroundColor: 'white',
			borderRadius:0,
		
			textStyle:{
				color:"#4B4B4B",
				fontWeight: 'normal',
            	fontFamily: 'sans-serif',
            	fontSize: '11px'
			},
			extraCssText: 'box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);'
		},
		legend:{show:false},
		grid: {
			
			show:false,
			top:'10%',
			left: '0%',
			right: '0%',
			bottom: '0%',
			containLabel: false
		},
		 xAxis: [
			 {
				
				 axisLine:{
					 show:false,
				 },
				 axisTick:{
					show:false,
				},
				type: 'category',
        		data: [],
        		splitLine: {
          			show: false
       			},
			 },
		],
		yAxis: [	
			{
				axisLine:{
					show:false,
				},
			  	type: 'value',
			  	splitLine: {
					show: false
			  	},
			}
		],
		series: [
			{
			  name: 'New Users',
			  type: 'bar',
			  barWidth: "90%",
			  stack: 'Ad',
			  emphasis: {
				focus: 'series'
			  },
			  itemStyle: {color: '#5292EF'},
			  data: []
			},
			{
			  name: 'Returning Users',
			  type: 'bar',
			  stack: 'Ad',
			  emphasis: {
				focus: 'series'
			  },
			  itemStyle:{color:"#E5E5E5"},
			  data: []
			},
		   
		   
		  ],
	}

	ngOnInit(){
		let data = [[],[]]
	
		var max = 90;
   		var min = 80;

		for (var i = 0; i < 40; i++) {
			let x = [i, Math.round(Math.random() * (max - min) + min)];
			data[0].push(x);
			x = [i, Math.round(Math.random() * (max - min) + min)];
			data[1].push(x);
			this.chartOption.xAxis[0].data.push(" ");
		}

		this.chartOption.series[0].data = data[0];
		this.chartOption.series[1].data = data[1];
	}


	ngOnDestroy(){

	}
//   chartOptions;
//   timeout;
//   chartData = [
//     {
//       key: 'New Users',
//       values: []
//     },
//     {
//       key: 'Returning Users',
//       values: []
//     }
//   ];

//   ngOnInit() {
//     //Generate Random Data
//     let data = [[], []];

//     var max = 90;
//     var min = 80;

    // for (var i = 0; i < 40; i++) {
    //   let x = [i, Math.round(Math.random() * (max - min) + min)];
    //   data[0].push(x);
    //   x = [i, Math.round(Math.random() * (max - min) + min)];
    //   data[1].push(x);
    // }
//     this.chartData[0]['values'] = data[0];
//     this.chartData[1]['values'] = data[1];
//   }

//   ngAfterViewInit() {
//     this.timeout = setTimeout(() => {
//       this.chartOptions = {
//         chart: {
//           type: 'multiBarChart',
//           color: [pg.getColor('complete'), pg.getColor('contrast-low')],
//           x: function(d) {
//             return d[0];
//           },
//           y: function(d) {
//             return d[1];
//           },
//           multibar: {
//             stacked: true
//           },
//           showControls: false,
//           useInteractiveGuideline: false,
//           margin: {
//             top: 0,
//             right: 0,
//             bottom: 0,
//             left: 0
//           },
//           yDomain: [0, 200],
//           showLegend: false,
//           showXAxis: false,
//           showYAxis: false,
//           interactive: false
//         }
//       };
//     }, 2000);
//   }
//   ngOnDestroy() {
//     clearTimeout(this.timeout);
//   }
}
