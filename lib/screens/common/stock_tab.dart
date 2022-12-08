import 'package:flutter/material.dart';

class StockTab extends StatefulWidget {
  @override
  _StockTabState createState() => _StockTabState();

}

class _StockTabState extends State<StockTab>{


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double tabHeight = 30;
    return TabBar(
        tabs: [
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: const Text('호가'),
          ),
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: const Text('차트'),
          ),
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: const Text('체결'),
          ),
        ]
    );
  }

}
