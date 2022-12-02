import 'package:flutter/material.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:flutter_mts/utils/formatter_number.dart';
import 'package:get/get.dart';

class HokaScreen extends StatefulWidget {
  final String trKey = '005930'; // 대상 주식 종목 코드
  final String hokaServiceCd = 'H0STASP0'; // 실시간 주식 호가 서비스 코드
  final String cntgServiceCd = 'H0STCNT0'; // 실시간 주식 체결 서비스 코드

  @override
  _HokaScreenState createState() => _HokaScreenState();
}

class _HokaScreenState extends State<HokaScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isAppbarOpen = true; // Appbar 확장 여부

  /* GetX Controller */
  late SocketController hokaSocketController; // 실시간 호가
  late SocketController cntgSocketController; // 실시간 체결가

  /* GetX tag */
  late final String hokaTag;
  late final String cntgTag;

  @override
  void initState() {
    super.initState();
    hokaTag = '${widget.hokaServiceCd}_${widget.trKey}';
    cntgTag = '${widget.cntgServiceCd}_${widget.trKey}';
    initScrollController();

    /* 장마감 시, 주석처리 */
    initSocketController();
  }

  void initScrollController () { // scroll offset 에 따른 appbar 확장 상태 제어
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

  void initSocketController () { // data 를 받아오고 저장할 socket, store 초기화
    hokaSocketController = SocketController(
      serviceCd: widget.hokaServiceCd,
      keys: [widget.trKey],
    );
    cntgSocketController = SocketController(
      serviceCd: widget.cntgServiceCd,
      keys: [widget.trKey]
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
                flexibleSpace: HokaAppbar(isOpen: isAppbarOpen, hokaTag: hokaTag, cntgTag: cntgTag ),
              ),
              SliverToBoxAdapter(
                child: HokaList(hokaTag: hokaTag, cntgTag: cntgTag,),
              )
            ],
          )
      ),
    );
  }
}
class HokaAppbar extends StatefulWidget {
  final bool isOpen;
  final String hokaTag;
  final String cntgTag;

  HokaAppbar({
    required this.isOpen,
    required this.hokaTag,
    required this.cntgTag
  });

  @override
  _HokaAppbarState createState () => _HokaAppbarState();
}

class _HokaAppbarState extends State<HokaAppbar> {

  /*
  * TODO
  * utils 분리
  * enum 처리
  * */
  Color getColorByCode(String data) {
    switch (data){
      case '1': // 상한
      case '2': // 상승
        return Colors.red;
      case '4': // 하한
      case '5': // 하락
        return Colors.blue;
      case '3': // 보합
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var hokaController = Get.find<StockDataController>(tag: widget.hokaTag);
      var cntgController = Get.find<StockDataController>(tag: widget.cntgTag);
      if (hokaController.stockData.value == '' || cntgController.stockData.value == '') {
        return const CircularProgressIndicator();
      } else {
        KisStockPurchase hoka = KisStockPurchase.parse(hokaController.stockData.value);
        KisStockCntg cntg = KisStockCntg.parse(cntgController.stockData.value);
        final textColor = getColorByCode(cntg.prevDayVersusSign);

        if (widget.isOpen) { // 확장 Appbar
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Text('${hoka.MKSC_SHRN_ISCD} | 코스피', style: const TextStyle(fontSize: 14)),
                  Text(formatCurrency(cntg.stockCurPrice), style: TextStyle(fontSize: 32, color: textColor),),
                  Text(formatCurrency(formatAbsoluteValue(cntg.prevDayVersus)), style: TextStyle(fontSize: 14, color: textColor)),
                  Text('${formatAbsoluteValue(cntg.prevDayContrastRatio)}%', style: TextStyle(fontSize: 14, color: textColor)),
                  Text('${hoka.accumulateVolume} 주', style: const TextStyle(fontSize: 14))
                ]
            ),
          );
        } else { // 축소 Appbar
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Text('${hoka.MKSC_SHRN_ISCD} | 코스피', style: const TextStyle(fontSize: 14)),
                  Text(formatCurrency(cntg.stockCurPrice), style: TextStyle(fontSize: 32, color: textColor),),
                ]
            ),
          );
        }
      }
    });
  }
}

class HokaList extends StatelessWidget {
  final double listItemHeight = 40.0;
  late final String hokaTag;
  late final String cntgTag;
  HokaList({required this.hokaTag, required this.cntgTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var hokaController = Get.find<StockDataController>(tag: hokaTag);
      var cntgController = Get.find<StockDataController>(tag: cntgTag);

      if (hokaController.stockData.value == '' || cntgController.stockData.value == '') {
        return const CircularProgressIndicator();
      } else {
        KisStockPurchase hoka = KisStockPurchase.parse(hokaController.stockData.value);
        KisStockCntg cntg = KisStockCntg.parse(cntgController.stockData.value);
        return Column(
          children: [
            /* Ask Price */
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: hoka.getAskPriceRestQuantityMap().map((e) {
                        return Row(
                          children: [
                            Expanded(flex:1, child: Container(color: Colors.blue, height: listItemHeight, child: Text(e.value),)),
                            Expanded(
                              flex:1,
                              child:
                              e.key == cntg.stockCurPrice
                                  ? Container(
                                height: listItemHeight,
                                decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
                                child: Text(formatCurrency(e.key)),
                              )
                                  : Container(
                                height: listItemHeight,
                                child: Text(formatCurrency(e.key)),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(color: Colors.grey, child: Text('container'),)
                )
              ],
            ),
            /* Bid Price */
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(color: Colors.grey, child: Text('container'),)
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: hoka.getBidPriceRestQuantityMap().map((e) {
                          return Row(
                            children: [
                              Expanded(
                                flex:1,
                                child:
                                e.key == cntg.stockCurPrice
                                    ? Container(
                                  height: listItemHeight,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
                                  child: Text(formatCurrency(e.key)),
                                )
                                    : Container(
                                  height: listItemHeight,
                                  child: Text(formatCurrency(e.key)),
                                ),
                              ),
                              Expanded(flex:1, child: Container(color: Colors.red, height: listItemHeight, child: Text(e.value))),
                            ],
                          );
                        }).toList()
                    )
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}


