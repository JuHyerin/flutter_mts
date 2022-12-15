import 'package:flutter_mts/interface/api/api_request_data.dart';

class KisChartPriceReq implements ApiRequestData{
  final String FID_COND_MRKT_DIV_CODE; // J : 주식, ETF, ETN
  final String FID_INPUT_ISCD; // 종목번호 (6자리)
  final String FID_INPUT_DATE_1; // 조회 시작일자 (ex. 20220501)
  final String FID_INPUT_DATE_2; // 조회 종료일자 (ex. 20220530)
  final String FID_PERIOD_DIV_CODE; // D:일봉, W:주봉, M:월봉, Y:년봉
  final String FID_ORG_ADJ_PRC; //0:수정주가 1:원주가

  KisChartPriceReq({
      required this.FID_COND_MRKT_DIV_CODE,
      required this.FID_INPUT_ISCD,
      required this.FID_INPUT_DATE_1,
      required this.FID_INPUT_DATE_2,
      required this.FID_PERIOD_DIV_CODE,
      required this.FID_ORG_ADJ_PRC
  });

  @override
  Map<String, String> toJson() {
    return {
      "fid_cond_mrkt_div_code": FID_COND_MRKT_DIV_CODE,
      "fid_input_iscd": FID_INPUT_ISCD,
      "fid_input_date_1": FID_INPUT_DATE_1,
      "fid_input_date_2": FID_INPUT_DATE_2,
      "fid_period_div_code": FID_PERIOD_DIV_CODE,
      "fid_org_adj_prc": FID_ORG_ADJ_PRC
    };
  }
}
