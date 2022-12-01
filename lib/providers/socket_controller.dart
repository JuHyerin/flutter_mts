import 'dart:convert';
import 'package:flutter_mts/models/kis_socket_request_param.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:flutter_mts/store/token_controller.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/*
* 서비스 별로 instance 생성 (serviceCd)
* 종목코드마다 Socket 생성하여 Map<종목코드, Socket>으로 관리 (channelMap)
* tag 사용하여 GetX Store 에 실시간 데이터 저장 (tag: serviceCd_trKey)
* */
class SocketController {
  final String serverUrl = 'ws://ops.koreainvestment.com:31000/tryitout/';
  late final String serviceCd;
  late Map<String, WebSocketChannel> channelMap = {}; // key: 종목코드(trKey)
  late String socketAccessToken;

  SocketController({
    required this.serviceCd,
    required List<String> keys
  }) {
    TokenController controller = Get.find<TokenController>();
    socketAccessToken = controller.socketAccessToken!;
    for(var key in keys){
      addChannel(key); // 종목코드 별 socket 생성 후, data 전송
      // addStore(key);
    }
  }

  Uri _buildSocketUri() => Uri.parse('$serverUrl$serviceCd');

  Parameter _buildParams(String trKey) {
    return KisSocketRequestParam(
      header: KisSocketRequestHeader(
        approvalKey: socketAccessToken,
        custType: 'P',
        trType: 1
      ),
      body: KisSocketRequestBody(trId: serviceCd, trKey: trKey)
    );
  }

  Future<void> addChannel(String key) async { // socket channel 생성 > 구독 > store 추가 > socket 요청
    addStore(key); // socket 연결되는 동안 screen 에 쓰이는 GetX 가 null 값임을 방지하기 위해 store 먼저 추가
    WebSocketChannel channel = await WebSocketChannel.connect(_buildSocketUri());
    channel.stream.listen(
      (event) {
        // print('[${key}_socket_data] $event');
        updateDataStore(key, event);
      }, // onData: Stream 에 데이터(event) 들어올 때마다 실행
      // onError: (e) => print('[${key}_socket_error] ${e.toString()}'),
      // onDone: () => print('[${key}_socket_done]'),
    );
    channelMap[key] = channel;
    sendData(key);
  }

  void sendData(String key){ // Socket 에 데이터 요청 -> Stream 으로 데이터 응답됨
    channelMap[key]!.sink.add(jsonEncode(_buildParams(key).toJson()));
  }

  void addStore(String key) { // Store 생성
    Get.put(StockDataController(), tag: '${serviceCd}_$key');
  }

  void updateDataStore(String key, dynamic event) { // response 파싱하여 실시간 데이터일 경우에만 Store update
    String tag = '${serviceCd}_$key';
    final StockDataController controller = Get.find<StockDataController>(tag: tag);
    if(event[0] == '0' || event[0] == '1') { // 실시간 데이터
      String newData = KisSocketResponse.parse(event).data;
      controller.updateData(newData);
    } else {
      print('[SocketResponse] $event');
    }
  }

  List<MapEntry<String, WebSocketChannel>> mapToList() {
    List<MapEntry<String, WebSocketChannel>> list = [];
    channelMap.forEach((key, value) => list.add(MapEntry(key, value)));
    return list;
  }
}
