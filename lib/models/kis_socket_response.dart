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
  late String HOUR_CLOSE_CODE; // 시간 구분 코드
  late List<String> askPriceList; // 매도호가 (주식 판매하고자 하는 금액), ASKP
  late List<String> bidPriceList; // 매수호가 (주식 구매하고자 하는 금액), BIDP
  late List<String> askRestQuantityList; // 매수호가 잔량, ASKP_RSQN
  late List<String> bidRestQuantityList; //매도호가 잔량, BIDP_RSQN
  late String totalAskRestQuantity; // 총 매수호가 잔량, TOTAL_ASKP_RSQN
  late String totalBidRestQuantity; // 총 매도호가 잔향, TOTAL_BIDP_RSQN
  late String overtimeTotalAskRestQuantity; // 시간외 총 매도호가 잔량, OVTM_TOTAL_ASKP_RSQN
  late String overtimeTotalBidRestQuantity; // 시간외 총 매수호가 잔량, OVTM_TOTAL_BIDP_RSQN
  late String anticipatedCnPrice; // 예상 체결가, ANTC_CNPR
  late String anticipatedCnQuantity; // 예상 체결량, ANTC_CNQN
  late String anticipatedVolume; // 예상 거래량, ANTC_VOL
  late String anticipatedCnVersus; // 예상 체결 대비	,ANTC_CNTG_VRSS
  late String anticipatedCnVersusSign; // 예상 체결 대비 부호, ANTC_CNTG_VRSS_SIGN
  late String anticipatedCnPreDayContrastRatio; // 예상 체결 전일 대비율, ANTC_CNTG_PRDY_CTRT
  late String accumulateVolume; // 누적 거래량,	ACML_VOL
  late String totalAskRestQuantityIcDc;// 총 매도호가 잔량 증감,	TOTAL_ASKP_RSQN_ICDC
  late String totalBidRestQuantityIcDc; // 총 매수호가 잔량 증감,	TOTAL_BIDP_RSQN_ICDC
  late String overtimeTotalAskIcDc; // 시간외 총 매도호가 증감,	OVTM_TOTAL_ASKP_ICDC
  late String overtimeTotalBidIcDc; // 시간외 총 매수호가 증감,	OVTM_TOTAL_BIDP_ICDC
  late String stockDealCloseCode; // 주식 매매 구분 코드, STCK_DEAL_CLS_CODE

  KisStockPurchase.parse(String stringData) {
    List<String> list = stringData.split('^');
    MKSC_SHRN_ISCD = list[0];
    BSOP_HOUR = list[1];
    HOUR_CLOSE_CODE = list[2];
    askPriceList = list.sublist(3, 13);
    bidPriceList = list.sublist(13, 23);
    askRestQuantityList = list.sublist(23,33);
    bidRestQuantityList = list.sublist(33,43);
    totalAskRestQuantity = list[43];
    totalBidRestQuantity = list[44];
    overtimeTotalAskRestQuantity = list[45];
    overtimeTotalBidRestQuantity = list[46];
    anticipatedCnPrice = list[47];
    anticipatedCnQuantity = list[48];
    anticipatedVolume = list[49];
    anticipatedCnVersus = list[50];
    anticipatedCnVersusSign = list[51];
    anticipatedCnPreDayContrastRatio = list[52];
    accumulateVolume = list[53];
    totalAskRestQuantityIcDc = list[54];
    totalBidRestQuantityIcDc = list[55];
    overtimeTotalAskIcDc = list[56];
    overtimeTotalBidIcDc = list[57];
    stockDealCloseCode = list[58];
  }
}
