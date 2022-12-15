import 'package:get/get.dart';

class TokenController extends GetxController {
  late String? socketAccessToken; // 실시간(웹소켓) 접속키
  late String? oauthToken; // 접근 토큰

  TokenController({this.socketAccessToken, this.oauthToken});

  void updateSoketAccessToken(String val) {
    socketAccessToken = val;
    update();
  }

  void updateOauthToken(String val) {
    oauthToken = val;
    update();
  }

}
