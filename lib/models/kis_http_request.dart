import 'package:flutter_mts/interface/api/api_request_data.dart';

class KisHttpRequestHeader implements ApiRequestData {
  final String appkey;
  final String appsecret;
  final String trId;
  final String custType;

  KisHttpRequestHeader({
    required this.appkey,
    required this.appsecret,
    required this.trId,
    required this.custType,
  });

  @override
  Map<String, String> toJson() {
    return {
      "content-type": "application/json; charset=utf-8",
      "appkey": appkey,
      "appsecret": appsecret,
      "tr_id": trId,
      "custtype": custType,
    };
  }
}
