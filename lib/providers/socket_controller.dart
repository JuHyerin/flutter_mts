import 'dart:convert';

import 'package:flutter_mts/models/kis_socket_request_param.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

String serverUrl = 'ws://ops.koreainvestment.com:31000/tryitout/';

class SocketController {
  late final String serviceCd;
  late Map<String, WebSocketChannel> channelMap = {};

  SocketController({required this.serviceCd, required List<String> keys}) {
    KisSocketRequestHeader header = KisSocketRequestHeader(
        approvalKey: '93fba692-6041-4e19-9939-07bdae320979',
        custType: 'P',
        trType: 1
    );

    for(var key in keys){
      KisSocketRequestParam params = KisSocketRequestParam(
        header: header,
        body: KisSocketRequestBody(trId: serviceCd, trKey: key)
      );
      addChannel(key);
      addData(key, params);
    }
  }

  Uri buildSocketUri() => Uri.parse('$serverUrl$serviceCd');

  void addChannel(String key) {
    WebSocketChannel channel = WebSocketChannel.connect(buildSocketUri());
    channelMap[key] = channel;
  }

  void addData(String key, Parameter data){
    // KisSocketRequestParam data = KisSocketRequestParam(
    //   header: KisSocketRequestHeader(
    //       approvalKey: '93fba692-6041-4e19-9939-07bdae320979',
    //       custType: 'P',
    //       trType: 1
    //   ),
    //   body: KisSocketRequestBody(trId: serviceCd, trKey: key)
    // );

    channelMap[key]!.sink.add(jsonEncode(data.toJson()));
  }

  List<MapEntry<String, WebSocketChannel>> mapToList() {
    List<MapEntry<String, WebSocketChannel>> list = [];
    channelMap.forEach((key, value) => list.add(MapEntry(key, value)));
    return list;
  }
}
