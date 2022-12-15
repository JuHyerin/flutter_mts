import 'package:flutter/material.dart';
import 'package:flutter_mts/models/chart_data.dart';
import 'package:flutter_mts/models/kis_chart_price_response.dart';
import 'package:flutter_mts/providers/stock_api.dart';
import 'package:flutter_mts/screens/common/common_loading.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<KisChartPriceResponse>(
          future: StockApi().inquireDomesticStock({}),
          builder: (context, AsyncSnapshot<KisChartPriceResponse> snapshot) {
            if(!snapshot.hasData) {
              return CommonLoading();
            } else {
              late List<ChartData> chartData = snapshot.data!.output2.map((e) => ChartData.parse(e)).toList();
              return Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Price Chart */
                      Container(
                        height: MediaQuery.of(context).size.height*(3/4),
                          child: SfCartesianChart(
                            title: ChartTitle(text: '가격', textStyle: const TextStyle(fontSize: 10), alignment: ChartAlignment.near),
                            primaryXAxis: CategoryAxis(
                                isVisible: false
                            ),
                            primaryYAxis: NumericAxis(
                                numberFormat: NumberFormat('###,###,###'),
                                opposedPosition: true,
                                rangePadding: ChartRangePadding.additional

                            ),
                            series: <ChartSeries<ChartData, String>> [
                              CandleSeries<ChartData, String>(
                                  dataSource: chartData,
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
                          )
                      ),
                      /* Volume Chart */
                      Container(
                        height: MediaQuery.of(context).size.height*(1/4),
                          child: SfCartesianChart(
                            title: ChartTitle(text: '거래량', textStyle: const TextStyle(fontSize: 10), alignment: ChartAlignment.near),
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                                numberFormat: NumberFormat.compact(),
                                opposedPosition: true
                            ),
                            series: <ChartSeries<ChartData, String>> [
                              ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData chartData, _) => DateFormat('MM/d').format(chartData.x),
                                yValueMapper: (ChartData chartData, _) => chartData.volume,
                              )
                            ],
                          )
                      )
                    ],
                  )
              );
            }
          }
      )
    );
  }
}
