import 'package:flutter/material.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/screens/hoka/hoka_list.dart';


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
  }

  void initTag () { // store 에서 데이터 받아올 tag 초기화
    hokaTag = '${widget.hokaServiceCd}_$trKey';
    cntgTag = '${widget.cntgServiceCd}_$trKey';
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: HokaList(hokaTag: hokaTag, cntgTag: cntgTag,),
    );
  }
}

