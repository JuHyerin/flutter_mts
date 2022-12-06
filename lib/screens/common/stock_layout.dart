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
  late TabController _tabController;

  /* GetX Controller */
  late SocketController cntgSocketController; // 실시간 체결가

  /* GetX tag */
  late String cntgTag;

  @override
  void initState() {
    super.initState();
    initTag();
    initScrollController();
    initTabController();

    /* 장마감 시, 주석처리 */
    // initSocketController();
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

  void initTabController () {
    _tabController = TabController(
      length: 3,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
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

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            controller:  _scrollController,
            slivers: <Widget> [
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: 175.0,
                collapsedHeight: 120.0,
                flexibleSpace: StockAppbar(
                    isOpen: isAppbarOpen,
                    tabController: _tabController,
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
              SliverToBoxAdapter(
                /* Pages */
                child: StockPage(tabController: _tabController),
              )
            ],
          )
      ),
    );
  }

}
