import {
  Component,
  OnInit,
  OnDestroy,
  ViewEncapsulation,
  ViewChild,
  ElementRef,
} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { GraphTileWidgetService } from './graph-tile-widget.service';
declare let d3: any;
declare var pg: any;
import * as echarts from 'echarts';

//import echarts
import { EChartsOption } from 'echarts';
import { Console } from 'console';

@Component({
  selector: 'graph-tile-widget',
  templateUrl: './graph-tile-widget.component.html',
  styleUrls: ['./graph-tile-widget.component.scss'],
  providers: [GraphTileWidgetService],
  encapsulation: ViewEncapsulation.None,
})
export class GraphTileWidgetComponent implements OnInit, OnDestroy {
  nvd3LineData = [];
  nvd3LineOptions;
  service;
  timeout;
  lineData = [];

  constructor(
    private _service: GraphTileWidgetService,
    private http: HttpClient
  ) {}

  chartOption: EChartsOption = {};

  ngOnInit() {
    this.service = this._service.getChartSampleData().subscribe((d) => {
      this.timeout = setTimeout(() => {
        this.lineData = d['nvd3'].productRevenue;

        this.chartOption = {
          tooltip: {
            trigger: 'axis',
            formatter: 'Product Revenue : {c}',
            backgroundColor: 'white',
            borderRadius: 0,
            textStyle: {
              color: '#4B4B4B',
              fontWeight: 'normal',
              fontFamily: 'sans-serif',
              fontSize: '3px !important',
            },
            extraCssText: 'box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);',
          },

          grid: {
            show: false,
            top: '40%',
            left: '0%',
            right: '0%',
            bottom: '0%',
            containLabel: false,
          },
          xAxis: {
            type: 'category',
            interval: 10,
            show: true,
            boundaryGap: false,
            data: [],
            splitLine: {
              show: true,
              lineStyle: {
                color: '#E1E1E1',
              },
            },
            axisLine: {
              show: false,
            },
            axisTick: {
              show: false,
            },
            axisLabel: {
              interval: 1,
              inside: true,
              padding: [0, 0, 0, 20],
            },
          },
          yAxis: {
            axisLine: {
              show: false,
            },
            type: 'value',
            splitLine: {
              show: false,
            },
          },
          series: [
            {
              data: [],
              type: 'line',
              symbol: 'none',
              itemStyle: {
                color: '#17AD79',
              },
              areaStyle: {
                opacity: 0.3,
              },
            },
          ],
        };
        this.chartOption.xAxis.data = this.lineData[0].values.map(function (
          item
        ) {
          return item[0];
        });

        this.chartOption.series[0].data = this.lineData[0].values.map(function (
          item
        ) {
          return item[1] / 100;
        });
        // this.nvd3LineData = d["nvd3"].productRevenue;
        // this.nvd3LineOptions = {
        //   chart: {
        //     type: 'lineChart',
        //     color: [pg.getColor('success')],
        //     x: function(d) {
        //       return d[0];
        //     },
        //     y: function(d) {
        //       return d[1] / 100;
        //     },
        //     forceY: [0, 2],
        //     tooltip: {
        //       chartContainer: '#widget-4-container'
        //     },
        //     useInteractiveGuideline: false,
        //     margin: {
        //       top: 60,
        //       right: -10,
        //       bottom: -10,
        //       left: -10
        //     },
        //     showLegend: false
        //   }
        // };
      }, 1000);
    });
  }

  ngOnDestroy() {
    this.service.unsubscribe();
    clearTimeout(this.timeout);
  }
}
