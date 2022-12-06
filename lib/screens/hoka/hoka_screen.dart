import 'package:flutter/material.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/screens/hoka/hoka_appbar.dart';
import 'package:flutter_mts/screens/hoka/hoka_list.dart';


/*
* TODO
* 화면 크기 부족으로 HokaList 짤림
* Sliver 와 TabBar/TabBarView 같이 적용하는 방법
*  https://stackoverflow.com/questions/68640078/tabbarview-inside-sliver-with-stickyheader
* */


class HokaScreen extends StatefulWidget {
  // final String trKey = '005930'; // 대상 주식 종목 코드
  final String hokaServiceCd = 'H0STASP0'; // 실시간 주식 호가 서비스 코드
  final String cntgServiceCd = 'H0STCNT0'; // 실시간 주식 체결 서비스 코드

  @override
  _HokaScreenState createState() => _HokaScreenState();
}

class _HokaScreenState extends State<HokaScreen> {
  String trKey = '005930'; // 대상 주식 종목 코드

  /* GetX Controller */
  late SocketController hokaSocketController; // 실시간 호가
  late SocketController cntgSocketController; // 실시간 체결가

  /* GetX tag */
  late String hokaTag;
  late String cntgTag;

  @override
  void initState() {
    super.initState();
    initTag();

    /* 장마감 시, 주석처리 */
    initSocketController();
  }

  void initSocketController () { // data 를 받아오고 저장할 socket, store 초기화
    hokaSocketController = SocketController(
      serviceCd: widget.hokaServiceCd,
      keys: [trKey],
    );
    cntgSocketController = SocketController(
        serviceCd: widget.cntgServiceCd,
        keys: [trKey]
    );
  }

  void initTag () { // store 에서 데이터 받아올 tag 초기화
    hokaTag = '${widget.hokaServiceCd}_$trKey';
    cntgTag = '${widget.cntgServiceCd}_$trKey';
  }

  @override
  Widget build(BuildContext context) {

    return HokaList(hokaTag: hokaTag, cntgTag: cntgTag,);
  }
}



/*class HokaScreen extends StatefulWidget {
  // final String trKey = '005930'; // 대상 주식 종목 코드
  final String hokaServiceCd = 'H0STASP0'; // 실시간 주식 호가 서비스 코드
  final String cntgServiceCd = 'H0STCNT0'; // 실시간 주식 체결 서비스 코드

  @override
  _HokaScreenState createState() => _HokaScreenState();
}

class _HokaScreenState extends State<HokaScreen> {
  String trKey = '005930'; // 대상 주식 종목 코드
  final ScrollController _scrollController = ScrollController();
  bool isAppbarOpen = true; // Appbar 확장 여부

  *//* GetX Controller *//*
  late SocketController hokaSocketController; // 실시간 호가
  late SocketController cntgSocketController; // 실시간 체결가

  *//* GetX tag *//*
  late String hokaTag;
  late String cntgTag;

  @override
  void initState() {
    super.initState();
    initTag();
    initScrollController();

    *//* 장마감 시, 주석처리 *//*
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
      keys: [trKey],
    );
    cntgSocketController = SocketController(
      serviceCd: widget.cntgServiceCd,
      keys: [trKey]
    );
  }

  void initTag () { // store 에서 데이터 받아올 tag 초기화
    hokaTag = '${widget.hokaServiceCd}_$trKey';
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
                expandedHeight: 140.0,
                collapsedHeight: 85.0,
                flexibleSpace: HokaAppbar(
                  isOpen: isAppbarOpen,
                  hokaTag: hokaTag,
                  cntgTag: cntgTag,
                  trKey: trKey,
                  changeTrKey: (String value) {
                    setState(() {
                      trKey = value;
                    });
                    initTag();
                    hokaSocketController.addChannel(trKey);
                    cntgSocketController.addChannel(trKey);
                  }
                ),
              ),
              SliverToBoxAdapter(
                child: HokaList(hokaTag: hokaTag, cntgTag: cntgTag,),
              )
            ],
          )
      ),
    );
  }
}*/



