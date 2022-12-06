import 'package:flutter/material.dart';

class StockTab extends StatefulWidget {
  final TabController tabController;

  StockTab ({required this.tabController});

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
      controller: widget.tabController,
        tabs: [
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: Text(
              '호가',
            ),
          ),
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: Text(
              '차트',
            ),
          ),
          Container(
            height: tabHeight,
            alignment: Alignment.center,
            child: Text(
              '체결',
            ),
          ),
        ]
    );
  }

}
