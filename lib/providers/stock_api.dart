import 'dart:convert';
import 'dart:io';

import 'package:flutter_mts/models/kis_chart_price_request.dart';
import 'package:flutter_mts/models/kis_chart_price_response.dart';
import 'package:flutter_mts/models/kis_http_request.dart';
import 'package:flutter_mts/store/token_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StockApi {
  /* Singleton */
  // static final StockApi _instance = StockApi._internal();
  // factory StockApi() => _instance;

  final String httpServiceUrl = 'https://openapivts.koreainvestment.com:29443';

  final String appKey = dotenv.env['KIS_APP_KEY'] ?? '';
  final String secretKey = dotenv.env['KIS_SECRET_KEY'] ?? '';

  final String domesticServiceUri = '/uapi/domestic-stock';

  StockApi();

  StockApi.init() {
    Get.put(TokenController()); // 앱 시작할 때 TokenController 초기화
  }

  Uri buildHttpUri(String url) => Uri.parse('$httpServiceUrl$url');
  Uri buildHttpGetUri(String url, Map<String, dynamic>? params) =>
      Uri.https('openapivts.koreainvestment.com:29443', url, params);

  /* OAuth 토큰 발급 */
  Future<void> getOauthToken() async {
    const String url = '/oauth2/tokenP';
    final params = {
      'grant_type': 'client_credentials',
      'appkey': appKey,
      'appsecret': secretKey
    };
    final response = await http.post(
      buildHttpUri(url),
      body: jsonEncode(params)
    );
    final Map<String, dynamic> body = jsonDecode(response.body);
    final String accessToken = body['access_token'];

    final TokenController controller = Get.find<TokenController>();
    controller.updateOauthToken(accessToken);
  }

  /* POST API에 사용되는 hashkey 발급 */
  Future<String> getHashKey(Object params) async {
    const String url = '/uapi/hashkey';
    final response = await http.post(
      buildHttpUri(url),
      body: jsonEncode(params)
    );
    final Map<String, dynamic> body = jsonDecode(response.body);
    String hashKey = body['HASH'];

    return hashKey;
  }

  /* 실시간 토큰 발급 */
  Future<void> getSocketAccessToken() async {
    const String url = '/oauth2/Approval';
    final params = {
      'grant_type': 'client_credentials',
      'appkey': appKey,
      'secretkey': secretKey
    };
    final response = await http.post(
        buildHttpUri(url),
        body: jsonEncode(params)
    );
    final Map<String, dynamic> body = jsonDecode(response.body);
    final String approvalKey = body['approval_key'];

    final TokenController controller = Get.find<TokenController>();
    controller.updateSoketAccessToken(approvalKey);
  }

  /* 국내주식기간별시세(일/주/월/년) */
  Future<KisChartPriceResponse> inquireDomesticStock(Object params) async {
    final String url = '$domesticServiceUri/v1/quotations/inquire-daily-itemchartprice';

    final paramData = KisChartPriceReq( // sample data
        FID_COND_MRKT_DIV_CODE: 'J',
        FID_INPUT_ISCD: '005930',
        FID_INPUT_DATE_1: '20221201',
        FID_INPUT_DATE_2: '20221215',
        FID_PERIOD_DIV_CODE: 'D',
        FID_ORG_ADJ_PRC: '1'
    ).toJson();

    final response = await http.get(
      buildHttpGetUri(url, paramData),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${Get.find<TokenController>().oauthToken}',
        ...KisHttpRequestHeader(
            appkey: appKey,
            appsecret: secretKey,
            trId: 'FHKST03010100',
            custType: 'P'
        ).toJson(),
      }
    );
    final body = jsonDecode(response.body);
    final result = KisChartPriceResponse()..parse(body);

    return result;
  }
}






