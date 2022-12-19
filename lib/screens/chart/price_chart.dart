import 'package:flutter/material.dart';
import 'package:flutter_mts/models/chart_data.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChart extends StatefulWidget {
  ZoomPanBehavior zoomPanBehavior;
  List<ChartData> chartData;
  Function setGlobalZoomState;
  GlobalKey anotherChartKey;

  PriceChart(Key? key, {
    required this.zoomPanBehavior,
    required this.chartData,
    required this.setGlobalZoomState,
    required this.anotherChartKey,
  }): super(key: key);

  @override
  PriceChartState createState() => PriceChartState();

}

class PriceChartState extends State<PriceChart> {

  void refreshChart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: widget.zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        if(args.axis!.name == 'primaryXAxis'){ // X축 zoom 일 때만 set zoom state
          widget.setGlobalZoomState(args.currentZoomFactor, args.currentZoomPosition);
        }
        // widget.anotherChartKey.currentState!.refreshChart();
      },
      title: ChartTitle(text: '가격', textStyle: const TextStyle(fontSize: 10), alignment: ChartAlignment.near),
      primaryXAxis: CategoryAxis(
          isVisible: false,
          rangePadding: ChartRangePadding.auto,
          name: 'primaryXAxis'
      ),
      primaryYAxis: NumericAxis(
          numberFormat: NumberFormat('###,###,###'),
          opposedPosition: true,
          rangePadding: ChartRangePadding.additional

      ),
      series: <ChartSeries<ChartData, String>> [
        CandleSeries<ChartData, String>(
            dataSource: widget.chartData,
            xValueMapper: (ChartData chartData, _) => DateFormat('MM/d').format(chartData.x),
            lowValueMapper: (ChartData chartData, _) => chartData.low,
            highValueMapper: (ChartData chartData, _) => chartData.high,
            openValueMapper: (ChartData chartData, _) => chartData.open,
            closeValueMapper: (ChartData chartData, _) => chartData.close,
            bearColor: Colors.blue,
            bullColor: Colors.red,
            enableSolidCandles: true,
            yAxisName: '가격(수정)'
        ),
      ],
    );
  }

}
