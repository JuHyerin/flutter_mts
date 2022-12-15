import 'package:flutter_mts/models/kis_chart_price_response.dart';

import '../utils/formatter_date.dart';

class ChartData {
  late final DateTime x;
  late final num open;
  late final num high;
  late final num low;
  late final num close;
  late final num volume;
  late final int? volSign; // 0: 하락, 1: 상승

  ChartData({
    required this.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume
  });

  ChartData.parse(KisChartPriceItem item) {
    List<int> dateArray = stringToDateArray(item.stck_bsop_date);
    x = DateTime(dateArray[0], dateArray[1], dateArray[2]);
    open = item.stck_oprc;
    high = item.stck_hgpr;
    low = item.stck_lwpr;
    close = item.stck_clpr;
    volume = item.acml_vol;
  }
}
