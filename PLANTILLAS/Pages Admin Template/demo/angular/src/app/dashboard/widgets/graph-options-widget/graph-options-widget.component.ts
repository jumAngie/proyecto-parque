import { Component, OnInit, OnDestroy, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
// declare var pg: any;
// declare let d3: any;

//import echarts
import { EChartsOption } from 'echarts';
import { Console } from 'console';


@Component({
  selector: 'graph-options-widget',
  templateUrl: './graph-options-widget.component.html',
  styleUrls: ['./graph-options-widget.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class GraphOptionsWidgetComponent implements OnInit, OnDestroy {
  nvd3LineData = [
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
  nvd3LineOptions;
  timer;
  constructor() {}

  
  ngOnDestroy() {
    clearTimeout(this.timer);
  }

  chartOption: EChartsOption = {
	tooltip: {
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
			  color:"#17AD79"
		  },
		}
  ]
  }

  ngOnInit() {
	  this.chartOption.series[0].data = [0, 8, 20, 22, 30, 26, 10]
	}
//   ngAfterViewInit() {
//     this.timer = setTimeout(() => {
//       this.nvd3LineOptions = {
//         chart: {
//           type: 'lineChart',
//           color: [['#27cebc']],
//           x: function(d) {
//             return d[0];
//           },
//           y: function(d) {
//             return d[1];
//           },
//           useInteractiveGuideline: true,
//           clipEdge: false,
//           margin: {
//             top: 10,
//             right: -10,
//             bottom: 10,
//             left: -10
//           },
//           showLegend: false,
//           showXAxis: false,
//           showYAxis: false
//         }
//       };
//     }, 2000);
//   }
}
