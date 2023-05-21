import { Component, OnInit, OnDestroy, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
import { TrafficLayer } from '@ngui/map';
declare var pg: any;
// import 'd3';
// import 'nvd3';

//import echarts
import { EChartsOption } from 'echarts';
import * as echarts from 'echarts';

@Component({
  selector: 'realtime-widget',
  templateUrl: './realtime-widget.component.html',
  styleUrls: ['./realtime-widget.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class RealtimeWidgetComponent implements OnInit, OnDestroy {
  chartOptions;
  timeouts = [];
  datasetOne;
  datasetTwo;
  xAxisData
  mergeOptions={}
  chartData = [
    {
      key: 'Web Server',
      values: []
    },
    {
      key: 'DB Server',
      values: []
    }
  ];

  chartOption: EChartsOption = {}

  constructor() {}

  ngOnInit() {}

  ngOnDestroy(){}

  ngAfterViewInit(){
	let data = [[], []];

    var max = 50;
    var min = 30;

    for (var i = 0; i < 30; i++) {
      let x = [i, Math.round(Math.random() * (max - min) + min)];
      data[0].push(x);
      x = [i, Math.round(Math.random() * (max - min) + min)];
      data[1].push(x);
    }
  
	this.datasetOne = data[0].map(function(item){
		return item[1]
	})

	this.datasetTwo = data[1].map(function(item){
		return item[1]
	})

	this.xAxisData = data[0].map(function(item){
		return item[0]
	})

	setTimeout(() => {
		this.chartOption ={
			tooltip: {
				backgroundColor: 'white',
				borderRadius:0,
				trigger:'axis',
				textStyle:{
					color:"#4B4B4B",
					fontWeight: 'normal',
					fontFamily: 'sans-serif',
					fontSize: '11px'
				},
				extraCssText: 'box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);'
			},
			 
			  grid: {
				show:false,
				top:"0%",
				left: '0%',
				right: '0%',
				bottom: '0%',
				containLabel: false
			  },
			  xAxis: [
				{
				  type: 'category',
				  boundaryGap: false,
				  data:this.xAxisData,
				  axisLine:{
					show:false,
				},
				axisTick:{
						show:false,
					},
				}
			  ],
			  yAxis: [
				{
				  type: 'value',
				  axisLine:{
					show:false,
				},
				axisTick:{
					show:false,
				},
				splitNumber:2,
				
				splitLine:{
					show:true,
					lineStyle:{
						color:'#f5f5f5'
					}
				},
				axisLabel: {
					padding: [0, 0, 20, 0],
					showMaxLabel:false,
					show: true,
					inside:true
				  }
				
				}
			  ],
			  series: [
				{
				  name: 'Email',
				  type: 'line',
				  stack: 'Total',
				  symbol:'none',
				  itemStyle:{
					color:"#17AD79"
				  },
				  areaStyle: {color:"#17AD79"},
				  emphasis: {
					focus: 'series'
				  },
				  lineStyle:{
					width:0
				},
				  smooth:true,
				  data: this.datasetOne
				},
				{
				  name: 'Union Ads',
				  type: 'line',
				  symbol:'none',
				  stack: 'Total',
				  lineStyle:{
					  width:0
				  },
				  itemStyle:{
					color:"#E8E8E8"
				  },
				  areaStyle: {color:"#E8E8E8"},
				  emphasis: {
					focus: 'series'
				  },
				  smooth:true,
				  data: this.datasetTwo
				  
				},
				
			  ]
		  }
	},2000)
	
	this.timeouts.push(
		setTimeout(() => {
		  window.dispatchEvent(new Event('resize'));
		  // Enable to simulate real time chart
		  this.updateChart();
		}, 1000)
	  );
  }

  updateChart() {
    this.timeouts.push(
      setTimeout(() => {
        let data = [[], []];
        var max = 50;
        var min = 30;
        let x = Math.round(Math.random() * (max - min) + min);
        let y = Math.round(Math.random() * (max - min) + min);
		this.datasetOne.shift();
	 	this.datasetTwo.shift();
		this.xAxisData.shift();
		this.xAxisData.push(parseInt(this.xAxisData.slice(-1))+1)
		this.datasetOne.push(x);
		this.datasetTwo.push(y);

		this.mergeOptions = {
			xAxis:[{
				data: this.xAxisData
			}
			],
			series:[
				{
					name: 'Email',
					type: 'line',
					stack: 'Total',
					symbol:'none',
					areaStyle: {color:"#17AD79"},
					emphasis: {
					  focus: 'series'
					},
					lineStyle:{
					  width:0
				  },
					smooth:true,
					data: this.datasetOne
				  },
				  {
					name: 'Union Ads',
					type: 'line',
					symbol:'none',
					stack: 'Total',
					lineStyle:{
						width:0
					},
					areaStyle: {color:"#E8E8E8"},
					emphasis: {
					  focus: 'series'
					},
					smooth:true,
					data: this.datasetTwo
					
				  },
			]
			
		}
		
        this.updateChart();
      }, 1000)
    );
  }

//   ngAfterViewInit() {
    // let data = [[], []];

    // var max = 50;
    // var min = 30;

    // for (var i = 0; i < 30; i++) {
    //   let x = [i, Math.round(Math.random() * (max - min) + min)];
    //   data[0].push(x);
    //   x = [i, Math.round(Math.random() * (max - min) + min)];
    //   data[1].push(x);
    // }
    // this.chartData[0]['values'] = data[0];
    // this.chartData[1]['values'] = data[1];

//     setTimeout(() => {
//       this.chartOptions = {
//         chart: {
//           type: 'stackedAreaChart',
//           color: [pg.getColor('success'), pg.getColor('contrast-low')],
//           x: function(d) {
//             return d[0];
//           },
//           y: function(d) {
//             return d[1];
//           },
//           interpolate: 'cardinal',
//           yAxis: {
//             ticks: 2
//           },
//           showControls: false,
//           clipEdge: false,
//           useInteractiveGuideline: false,
//           margin: {
//             top: 0,
//             right: 0,
//             bottom: 0,
//             left: 0
//           },
//           showLegend: false,
//           showXAxis: false,
//           showYAxis: true,
//           interactive: true
//         }
//       };
//     }, 2000);

    // this.timeouts.push(
    //   setTimeout(() => {
    //     window.dispatchEvent(new Event('resize'));
    //     // Enable to simulate real time chart
    //     //this.updateChart();
    //   }, 1000)
    // );
//   }

//   ngOnDestroy() {
//     for (const timeout of this.timeouts) {
//       clearTimeout(timeout);
//     }
//   }
}
