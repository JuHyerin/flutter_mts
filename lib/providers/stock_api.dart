import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StockApi {
  /* Singleton */
  // static final StockApi _instance = StockApi._internal();
  // factory StockApi() => _instance;

  final String httpServiceUrl = 'https://openapivts.koreainvestment.com:29443';
  final String socketServiceUrl = 'ws://ops.koreainvestment.com:31000/';

  final String? appKey = dotenv.env['KIS_APP_KEY'];
  final String? secretKey = dotenv.env['KIS_SECRET_KEY'];


  Uri buildHttpUri(String url) => Uri.parse('$httpServiceUrl$url');


  /* OAuth 토큰 발급 */
  Future<String> getAccessToken() async {
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

    print('accessToken>> $accessToken');
    return accessToken;
  }

  /* 실제 API에 사용되는 hashkey 발급 */
  Future<String> getHashKey(Object params) async {
    const String url = '/uapi/hashkey';
    final response = await http.post(
      buildHttpUri(url),
      body: jsonEncode(params)
    );
    return '';
  }
}
