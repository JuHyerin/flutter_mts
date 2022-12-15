import 'package:flutter_mts/interface/api/api_response_data.dart';

class KisChartCurInfo implements ApiResponseData{
  late final num prdy_vrss; // 전일 대비
  late final int prdy_vrss_sign2; // 전일 대비 부호
  late final num prdy_ctrt; // 전일 대비율
  late final int stck_prdy_clpr; // 주식 전일 종가
  late final int acml_vol; // 누적 거래량
  late final int acml_tr_pbmn; // 누적 거래 대금
  late final String hts_kor_isnm; // HTS 한글 종목명
  late final int stck_prpr; // 주식 현재가
  late final String stck_shrn_iscd; // 주식 단축 종목코드
  late final int prdy_vol; // 전일 거래량
  late final int stck_mxpr; // 상한가
  late final int stck_llam; // 하한가
  late final int stck_oprc; // 시가
  late final int stck_hgpr; // 최고가
  late final int stck_lwpr; // 최저가
  late final int stck_prdy_oprc; // 주식 전일 시가
  late final int stck_prdy_hgpr; // 주식 전일 최고가
  late final int stck_prdy_lwpr; // 주식 전일 최저가
  late final int askp; // 매도호가
  late final int bidp; // 매수호가
  late final int prdy_vrss_vol; // 전일 대비 거래량
  late final num vol_tnrt; // 거래량 회전율
  late final int stck_fcam; // 주식 액면가
  late final int lstn_stcn; // 상장 주수
  late final int cpfn; // 자본금
  late final int hts_avls; // 시가총액
  late final num per; // PER
  late final num eps; // EPS
  late final num pbr; //PBR
  late final num itewhol_loan_rmnd_ratem_name; // 전체 융자 잔고 비율율


  @override
  parse(Map<String, dynamic> data) {
  }
}

class KisChartPriceItem implements ApiResponseData{
  late final String stck_bsop_date; //	주식 영업 일자
  late final int stck_clpr; //	주식 종가
  late final int stck_oprc; //	주식 시가
  late final int stck_hgpr; //	주식 최고가
  late final int stck_lwpr; //	주식 최저가
  late final int acml_vol; //	누적 거래량
  late final int acml_tr_pbmn; //	누적 거래 대금
  late final String flng_cls_code; //	락 구분 코드 - 00:해당사항없음(락이 발생안한 경우), 01:권리락, 02:배당락, 03:분배락, 04:권배락, 05:중간(분기)배당락, 06:권리중간배당락. 07:권리분기배당락
  late final num prtt_rate; //	분할 비율
  late final String mod_yn; // 분할변경여부
  late final String prdy_vrss_sign;	// 전일 대비 부호
  late final num prdy_vrss;	// 전일 대비
  late final String revl_issu_reas; // 재평가사유코드

  @override
  parse(Map<String, dynamic> data) {
    stck_bsop_date = data['stck_bsop_date'];
    stck_clpr = int.parse(data['stck_clpr']);
    stck_oprc = int.parse(data['stck_oprc']);
    stck_hgpr = int.parse(data['stck_hgpr']);
    stck_lwpr = int.parse(data['stck_lwpr']);
    acml_vol = int.parse(data['acml_vol']);
    acml_tr_pbmn = int.parse(data['acml_tr_pbmn']);
    flng_cls_code = data['flng_cls_code'];
    prtt_rate = num.parse(data['prtt_rate']);
    mod_yn = data['mod_yn'];
    prdy_vrss_sign = data['prdy_vrss_sign'];
    prdy_vrss = num.parse(data['prdy_vrss']);
    revl_issu_reas = data['revl_issu_reas'];
  }
}

class KisChartPriceResponse implements ApiResponseData {
  late final String rt_cd; // 성공 실패 여부 (0 : 성공, 0 이외의 값 : 실패)
  late final String msg_cd; // 응답코드
  late final String msg1; // 응답메세지
  late final KisChartCurInfo output1; // 응답상세
  List<KisChartPriceItem> output2 = []; //일별데이터

  @override
  parse(Map<String, dynamic> body) {
    rt_cd = body['rt_cd'];
    msg_cd = body['msg_cd'];
    msg1 = body['msg1'];
    output1 = KisChartCurInfo()..parse(body['output1']);
    body['output2'].reversed.forEach((e) => output2.add(KisChartPriceItem()..parse(e)));
  }

}

