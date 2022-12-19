import 'package:flutter/material.dart';
import 'package:flutter_mts/models/chart_data.dart';
import 'package:flutter_mts/models/kis_chart_price_response.dart';
import 'package:flutter_mts/providers/stock_api.dart';
import 'package:flutter_mts/screens/chart/price_chart.dart';
import 'package:flutter_mts/screens/chart/volume_chart.dart';
import 'package:flutter_mts/screens/common/common_loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final priceChartKey = GlobalKey<PriceChartState>();
final volumeChartKey = GlobalKey<VolumeChartState>();

class ChartScreen extends StatefulWidget {

  @override
  _ChartScreenState createState() => _ChartScreenState();
}


class _ChartScreenState extends State<ChartScreen> {
  /* Chart Zoom 기능 controller */
  late ZoomPanBehavior _zoomPanBehavior;

  /* Price Chart-Volume Chart Zoom Sync 맞추기 위한 Zoom State */
  late double zoomF; // 확대 정도
  late double zoomP; // 확대 후 스크롤

  void setGlobalZoomState(double factor,double position) {
    setState(() {
      zoomF = factor;
      zoomP = position;
    });
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    zoomF = 1.0; // 확대 안한 상태
    zoomP = 0.0;
    super.initState();
  }

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
                            child: PriceChart(priceChartKey,
                              zoomPanBehavior: _zoomPanBehavior,
                              chartData: chartData,
                              anotherChartKey: volumeChartKey,
                              setGlobalZoomState: setGlobalZoomState,
                            )
                        ),
                        /* Volume Chart */
                        Container(
                            height: MediaQuery.of(context).size.height*(1/4),
                            child: VolumeChart(volumeChartKey,
                              zoomFactor: zoomF,
                              zoomPosition: zoomP,
                              zoomPanBehavior: _zoomPanBehavior,
                              chartData: chartData,
                              anotherChartKey: priceChartKey,
                              setGlobalZoomState: setGlobalZoomState,
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
