import { Component, OnInit, OnDestroy, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
declare var pg: any;
// declare var echarts: any;

//import echarts
import { EChartsOption } from 'echarts';

@Component({
  selector: 'bar-tile-widget',
  templateUrl: './bar-tile-widget.component.html',
  styleUrls: ['./bar-tile-widget.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class BarTileWidgetComponent implements OnInit, OnDestroy {
  constructor(private _host: ElementRef) { }

  chartOption: EChartsOption = {
	tooltip: {
		trigger: 'axis',
		axisPointer: {
		  type: 'shadow'
		}
	},
	legend:{show:false},
	grid: {
		show:false,
		top:-50,
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
			scale:true,
			max:15,
			  type: 'value',
			  splitLine: {
				show: false
			  },
		}
	],
	series: [
		{
		  name: 'Site visits',
		  type: 'bar',
		  barWidth: "40%",
		  stack: 'Ad',
		  emphasis: {
			focus: 'series'
		  },
		  itemStyle: {color: '#D73C30'},
		  data: [[1, 10],
		  [2, 8],
		  [3, 5],
		  [4, 9],
		  [5, 5],
		  [6, 8],
		  [7, 10]]
		},
		{
		  name: 'Site new',
		  type: 'bar',
		  stack: 'Ad',
		  emphasis: {
			focus: 'series'
		  },
		  itemStyle:{color:"#E5E5E5"},
		  data: [[1, 0],
		  [2, 2],
		  [3, 5],
		  [4, 1],
		  [5, 5],
		  [6, 2],
		  [7, 0]]
		},
	   
	   
	  ],
}

  ngOnInit(){

  }

  ngOnDestroy(){

  }
//   chartOptions;
//   timeout;
//   chartData = [
//     {
//       key: 'Site visits',
//       values: [
    //     [1, 10],
    //     [2, 8],
    //     [3, 5],
    //     [4, 9],
    //     [5, 5],
    //     [6, 8],
    //     [7, 10]
    //   ]
//     },
//     {
//       key: 'Site new',
//       values: [
    //     [1, 0],
    //     [2, 2],
    //     [3, 5],
    //     [4, 1],
    //     [5, 5],
    //     [6, 2],
    //     [7, 0]
    //   ]
//     }
//   ];

//   ngOnInit() {}
//   ngOnDestroy() {
//     clearTimeout(this.timeout);
//   }
//   ngAfterViewInit() {
// 	let parentHeight = this._host.nativeElement.offsetParent.clientHeight;

//     this.timeout = setTimeout(() => {
//       this.chartOptions = {
//         chart: {
// 		  type: 'multiBarChart',
// 		  height: parentHeight,
//           color: [pg.getColor('danger'), pg.getColor('contrast-low')],
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
//           tooltip: {
//             enabled: false
//           },
//           margin: {
//             top: 0,
//             right: 0,
//             bottom: 0,
//             left: 0
//           },
//           groupSpacing: 0.7,
//           yDomain: [0, 10],
//           showLegend: false,
//           showXAxis: false,
//           showYAxis: false,
//           interactive: false
//         }
//       };
//     }, 2000);
//   }
}
