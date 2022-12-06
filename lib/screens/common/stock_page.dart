import 'package:flutter/material.dart';
import 'package:flutter_mts/screens/hoka/hoka_screen.dart';

class StockPage extends StatefulWidget {
  final TabController tabController;

  StockPage({required this.tabController});

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: TabBarView(
          controller: widget.tabController,
          children: [
            HokaScreen(),
            Container(
              color: Colors.yellow[200],
              alignment: Alignment.center,
              child: Text(
                '차트',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              color: Colors.green[200],
              alignment: Alignment.center,
              child: Text(
                '체결',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ]
      )
    );
  }

}
