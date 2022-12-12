import 'package:flutter/material.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/screens/common/stock_appbar.dart';
import 'package:flutter_mts/screens/common/stock_page.dart';

class StockLayout extends StatefulWidget {
  final String hokaServiceCd = 'H0STASP0'; // 실시간 주식 호가 서비스 코드
  final String cntgServiceCd = 'H0STCNT0'; // 실시간 주식 체결 서비스 코드

  @override
  _StockLayoutState createState() => _StockLayoutState();

}

class _StockLayoutState extends State<StockLayout> with TickerProviderStateMixin{
  String trKey = '005930'; // 대상 주식 종목 코드
  final ScrollController _scrollController = ScrollController();
  bool isAppbarOpen = true; // Appbar 확장 여부

  /* GetX Controller */
  late SocketController cntgSocketController; // 실시간 체결가

  /* GetX tag */
  late String cntgTag;

  @override
  void initState() {
    super.initState();
    initTag();
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
    cntgSocketController = SocketController(
        serviceCd: widget.cntgServiceCd,
        keys: [trKey]
    );
  }

  void initTag () { // store 에서 데이터 받아올 tag 초기화
    cntgTag = '${widget.cntgServiceCd}_$trKey';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          /*
          * NestedScrollView
          * 내부에 다른 스크롤 뷰를 중첩할 수 있는 스크롤 뷰로, 스크롤 위치가 본질적으로 연결되어 있음
          * TabBar 를 포함한 SliverAppBar 와 scrollable 한 TabBarView 를 갖는 scrollable view 위젯에 주로 쓰임
          * (SliverAppbar 의 스크롤과 TabBarView 의 스크롤이 따로 놀기 때문에 NestedScrollView 로 스크롤을 연결시킴)
          * */
            body: NestedScrollView(
              controller:  _scrollController,
              /* SliverAppBar with TabBar */
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      floating: false,
                      pinned: true,
                      snap: false,
                      expandedHeight: 192.0,
                      collapsedHeight: 121.0,
                      flexibleSpace: StockAppbar(
                          isOpen: isAppbarOpen,
                          cntgTag: cntgTag,
                          trKey: trKey,
                          changeTrKey: (String value) {
                            setState(() {
                              trKey = value;
                            });
                            initTag();
                            cntgSocketController.addChannel(trKey);
                          }
                      ),
                    ),
                  ];
                },
                /* Scrollable TabBarView */
                body: StockPage(),
              )
          ),
        )
    );
  }

}
