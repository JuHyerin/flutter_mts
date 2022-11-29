import 'package:flutter/material.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:get/get.dart';

class HokaScreen extends StatefulWidget {
  final String trKey = '005930';
  final String serviceCd = 'H0STASP0';

  @override
  _HokaScreenState createState() => _HokaScreenState();
}

class _HokaScreenState extends State<HokaScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isAppbarOpen = true;
  late SocketController socketController;

  @override
  void initState() {
    super.initState();
    initScrollController();
    initSocketController();
  }

  void initScrollController () {
    _scrollController.addListener(() {
      if(_scrollController.offset <= 0.5) {
        setState(() {
          isAppbarOpen = true;
        });
      } else {
        setState(() {
          isAppbarOpen = false;
        });
      }
    });
  }

  void initSocketController () {
    socketController = SocketController(
      serviceCd: widget.serviceCd,
      keys: [widget.trKey],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            controller:  _scrollController,
            slivers: <Widget> [
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: 140.0,
                collapsedHeight: 85.0,
                flexibleSpace: HokaAppbar(isOpen: isAppbarOpen),
              ),
              SliverToBoxAdapter(
                child: HokaList(tag: '${widget.serviceCd}_${widget.trKey}'),
              )
            ],
          )
      ),
    );
  }
}
class HokaAppbar extends StatefulWidget {
  bool isOpen;
  HokaAppbar({required this.isOpen});

  @override
  _HokaAppbarState createState () => _HokaAppbarState();
}

class _HokaAppbarState extends State<HokaAppbar> {

  @override
  Widget build(BuildContext context) {
    if(widget.isOpen) {
      return FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(padding: EdgeInsets.all(5)),
              Text('종목코드 | 코스피', style: TextStyle(fontSize: 14)),
              Text('61,650', style: TextStyle(fontSize: 32),),
              Text('-1,100', style: TextStyle(fontSize: 14)),
              Text('-1,75%', style: TextStyle(fontSize: 14)),
              Text('11,616,567 주 (?? %)', style: TextStyle(fontSize: 14))
            ]
        ),
      );
    } else {
      return FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(padding: EdgeInsets.all(5)),
              Text('종목코드 | 코스피', style: TextStyle(fontSize: 14)),
              Text('61,650', style: TextStyle(fontSize: 32),),
            ]
        ),
      );
    }
  }
}

class HokaList extends StatelessWidget {
  final String tag;
  HokaList({required this.tag});

  @override
  Widget build(BuildContext context) {
    // return GetX<StockDataController>(
    //   tag: tag,
    //   builder: (controller) {
        // if (controller.stockData == '') {
        //   return CircularProgressIndicator();
        // } else {
        //   KisStockPurchase data = KisStockPurchase.parse(controller.stockData.value);
          return  Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,

                        children: /*data.getAskPriceRestQuantityMap().map((e) {
                          return Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text(e.value), height: 50,)),
                              Expanded(flex:1, child: Text(e.key)),
                            ],
                          );
                        }).toList(),*/
                        [
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest1'), height: 50,)),
                              Expanded(flex:1, child: Text('Ask1')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest2'), height: 50)),
                              Expanded(flex:1, child: Text('Ask2')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest3'), height: 50)),
                              Expanded(flex:1, child: Text('Ask3')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest4'), height: 50)),
                              Expanded(flex:1, child: Text('Ask4')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest5'), height: 50)),
                              Expanded(flex:1, child: Text('Ask5')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest6'), height: 50,)),
                              Expanded(flex:1, child: Text('Ask6')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest7'), height: 50)),
                              Expanded(flex:1, child: Text('Ask7')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest8'), height: 50)),
                              Expanded(flex:1, child: Text('Ask8')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest9'), height: 50)),
                              Expanded(flex:1, child: Text('Ask9')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Container(color: Colors.blue, child: Text('rest10'), height: 50)),
                              Expanded(flex:1, child: Text('Ask10')),
                            ],
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        child: Text('container'),
                      )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        child: Text('container'),
                      )
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid1')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest1'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid2')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest2'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid3')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest3'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid4')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest4'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid5')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest5'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid6')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest6'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid7')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest7'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid8')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest8'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid9')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest9'), height: 50)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:1, child: Text('Bid10')),
                              Expanded(flex:1, child: Container(color: Colors.red, child: Text('rest10'), height: 50)),
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ],
          );
        // }

      // },
    // );
  }
}


