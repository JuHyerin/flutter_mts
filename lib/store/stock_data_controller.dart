import 'package:get/get.dart';

/*
* Kis Socket Response 의 StringData 서비스와 종목별로 저장, tag 로 구분
* tag: serviceCd_trKey
* */
class StockDataController extends GetxController {
  RxString stockData = ''.obs;
  StockDataController();
  StockDataController.forTest(String data) {
    stockData = data.obs;
  }
  void updateData(String newData) {
  /*PINGPONG 이 아닐 때만 update 하기 위한 GetX Event*/
    stockData(newData);
  }
}

