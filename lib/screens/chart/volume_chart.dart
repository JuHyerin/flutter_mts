import 'package:flutter/material.dart';
import 'package:flutter_mts/models/chart_data.dart';
import 'package:flutter_mts/screens/chart/price_chart.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VolumeChart extends StatefulWidget {
  double zoomFactor;
  double zoomPosition;
  ZoomPanBehavior zoomPanBehavior;
  List<ChartData> chartData;
  Function setGlobalZoomState;
  GlobalKey<PriceChartState> anotherChartKey;

  VolumeChart(Key? key, {
    required this.zoomFactor,
    required this.zoomPosition,
    required this.zoomPanBehavior,
    required this.chartData,
    required this.setGlobalZoomState,
    required this.anotherChartKey,
  }): super(key: key);


  @override
  VolumeChartState createState() => VolumeChartState();

}

class VolumeChartState extends State<VolumeChart> {
  late GlobalKey anotherChartKey;

  void refreshChart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: widget.zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        if(args.axis!.name == 'primaryXAxis') { // X축 zoom 일 때만 set zoom state
          widget.setGlobalZoomState(args.currentZoomFactor, args.currentZoomPosition);
        }
        // anotherChartKey.currentState?.refreshChart();

      },
      title: ChartTitle(text: '거래량', textStyle: const TextStyle(fontSize: 10), alignment: ChartAlignment.near),
      primaryXAxis: CategoryAxis(zoomFactor: widget.zoomFactor, zoomPosition: widget.zoomPosition, name: 'primaryXAxis'),
      primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.compact(),
          opposedPosition: true,
      ),
      series: <ChartSeries<ChartData, String>> [
        ColumnSeries<ChartData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartData chartData, _) => DateFormat('MM/d').format(chartData.x),
          yValueMapper: (ChartData chartData, _) => chartData.volume,
        )
      ],
    );
  }

}
