import 'dart:convert';
import 'package:flutter_mts/models/kis_socket_request_param.dart';
import 'package:flutter_mts/store/token_controller.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

String serverUrl = 'ws://ops.koreainvestment.com:31000/tryitout/';

class SocketController {
  late final String serviceCd;
  late Map<String, WebSocketChannel> channelMap = {};
  late String socketAccessToken;

  SocketController({
    required this.serviceCd,
    required List<String> keys,
  }) {
    TokenController controller = Get.find<TokenController>();
    socketAccessToken = controller.socketAccessToken!;
    for(var key in keys){
      addChannel(key);
    }
  }

  Uri buildSocketUri() => Uri.parse('$serverUrl$serviceCd');

  Parameter buildParams(String trKey) {
    return KisSocketRequestParam(
      header: KisSocketRequestHeader(
        approvalKey: socketAccessToken,
        custType: 'P',
        trType: 1
      ),
      body: KisSocketRequestBody(trId: serviceCd, trKey: trKey)
    );
  }

  void addChannel(String key) {
    WebSocketChannel channel = WebSocketChannel.connect(buildSocketUri());
    channelMap[key] = channel;
    addData(key);
  }

  void addData(String key){
    channelMap[key]!.sink.add(jsonEncode(buildParams(key).toJson()));
  }

  List<MapEntry<String, WebSocketChannel>> mapToList() {
    List<MapEntry<String, WebSocketChannel>> list = [];
    channelMap.forEach((key, value) => list.add(MapEntry(key, value)));
    return list;
  }
}
