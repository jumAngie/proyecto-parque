import { Component, OnInit, OnDestroy, Input, ViewEncapsulation } from '@angular/core';
declare var pg: any;

//import echarts
import { EChartsOption } from 'echarts';

@Component({
  selector: 'graph-tile-flat-widget',
  templateUrl: './graph-tile-flat-widget.component.html',
  styleUrls: ['./graph-tile-flat-widget.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class GraphTileFlatWidgetComponent implements OnInit, OnDestroy {
  chartOptions;
  chartData = [
    {
      key: 'Site visits',
      values: [
        [100, 0],
        [150, 8],
        [200, 20],
        [250, 22],
        [300, 30],
        [350, 26],
        [400, 10]
      ]
    }
  ];
  _bgColor: string = 'bg-success';
  _pointColor: string = 'success';
  timeout;

  constructor() {}

  ngOnDestroy() {
    // clearTimeout(this.timeout);
  }

  chartOption: EChartsOption = {
	tooltip: {
		backgroundColor:"white",
		trigger: 'axis',
		axisPointer: {
		  type: 'shadow'
		}
	  },
	  
  
	  grid: {
		show:false,
		top:"10%",
		left: '0%',
		right: '0%',
		bottom: '0%',
		containLabel: false
	  },
	xAxis: {
		type: 'category',
		interval:10,
		boundaryGap: false,
		data: [],
		splitLine: {
			show: true
		  },
	
	  },
	  yAxis: {
		axisLine:{
			show:false,
		},
		type: 'value',
		splitLine: {
			show: false
		  },
	  },
	  series: [
		{
		  data: [],
		  type: 'line',
		  itemStyle:{
			  color:"white"
		  },
		}
  ]
  }

  ngOnInit() {
	  this.chartOption.series[0].data = [0, 8, 20, 22, 30, 26, 10]
	}

//   ngAfterViewInit() {
//     this.timeout = setTimeout(() => {
//       this.chartOptions = {
//         chart: {
//           type: 'lineChart',
//           color: [['#fff']],
//           x: function(d) {
//             return d[0];
//           },
//           y: function(d) {
//             return d[1];
//           },
//           tooltip: {
//             enabled: false
//           },
//           useInteractiveGuideline: false,
//           clipEdge: false,
//           margin: {
//             top: 10,
//             right: -10,
//             bottom: -13,
//             left: -10
//           },
//           showLegend: false,
//           showXAxis: false,
//           showYAxis: false,
//           showLegen: false,
//           interactive: false
//         }
//       };
//     });
//   }
//   @Input()
//   set BgColor(value: string) {
//     this._bgColor = value;
//     this._pointColor = value.replace('bg-', '');
//   }
}
