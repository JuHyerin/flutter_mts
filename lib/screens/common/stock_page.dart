import 'package:flutter/material.dart';
import 'package:flutter_mts/screens/chart/chart_screen.dart';
import 'package:flutter_mts/screens/cntg/cntg_screen.dart';
import 'package:flutter_mts/screens/hoka/hoka_screen.dart';

class StockPage extends StatefulWidget {

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
          children: [
            HokaScreen(),
            ChartScreen(),
            CntgScreen(),
          ]

    );
  }

}
