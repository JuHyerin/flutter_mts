class KisSocketResponse {
  late String isEncoded; // 암호화 유무 (0: 암호화x, 1: 암호화o)
  late String trID; // 등록한 tr_id
  late String dataCount; // 데이터 건수 (ex. 001 데이터 건수를 참조하여 활용)
  late String data; // 응답 데이터 (^로 구분됨)

  KisSocketResponse.parse(String recvString) {
    List<String> list = recvString.split('|');
    isEncoded = list[0];
    trID = list[1];
    dataCount = list[2];
    data = list[3];
  }
}

class KisStockData {
  // KisSocketResponse data
  /* TODO
  * GetxController의 State Type 을 Generic으로 지정 시도 (T extends KisStockData)
  * Kis 정보 객체 전용 Controller로 정의하기 위함
  * Controller 초기화에 문제 생김 (KisStockData().obs 불가)
  * */
}

class KisStockPurchase extends KisStockData{
  late String MKSC_SHRN_ISCD; // 유가증권 단축 종목코드
  late String BSOP_HOUR; // 영업 시간
  late String HOUR_CLS_CODE; // 시간 구분 코드
  late List<String> askPriceList; // 매도호가 (주식 판매하고자 하는 금액)
  /*late int askPrice1;
  late int askPrice2;
  late int askPrice3;
  late int askPrice4;
  late int askPrice5;
  late int askPrice6;
  late int askPrice7;
  late int askPrice8;
  late int askPrice9;
  late int askPrice10;*/
  late List<String> bidPriceList; // 매수호가 (주식 구매하고자 하는 금액)
  /*late int bidPrice1;
  late int bidPrice2;
  late int bidPrice3;
  late int bidPrice4;
  late int bidPrice5;
  late int bidPrice6;
  late int bidPrice7;
  late int bidPrice8;
  late int bidPrice9;
  late int bidPrice10;*/

  KisStockPurchase.parse(String stringData) {
    List<dynamic> list = stringData.split('^');
    MKSC_SHRN_ISCD = list[0];
    BSOP_HOUR = list[1];
    HOUR_CLS_CODE = list[2];
    askPriceList = list.sublist(3, 13) as List<String>;
    bidPriceList = list.sublist(13, 23) as List<String>;
    /*askPrice1 = list[3];
    askPrice2 = list[4];
    askPrice3 = list[5];
    askPrice4 = list[6];
    askPrice5 = list[7];
    askPrice6 = list[8];
    askPrice7 = list[9];
    askPrice8 = list[10];
    askPrice9 = list[11];
    askPrice10 = list[12];
    bidPrice1 = list[13];
    bidPrice2 = list[14];
    bidPrice3 = list[15];
    bidPrice4 = list[16];
    bidPrice5 = list[17];
    bidPrice6 = list[18];
    bidPrice7 = list[19];
    bidPrice8 = list[20];
    bidPrice9 = list[21];
    bidPrice10 = list[22];*/
  }
}
