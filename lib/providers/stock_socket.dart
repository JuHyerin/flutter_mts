import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class StockSocket {
  final String socketServiceUrl = 'ws://ops.koreainvestment.com:31000/tryitout/H0STASP0';
  Map<String,WebSocketChannel> channelMap = {};

  StockSocket(List<String> trIds) {
    for (var trId in trIds) {
      addChannel(trId);
    }
    // channel = WebSocketChannel.connect(buildSocketUri(url));
  }

  Uri buildSocketUri(String url) => Uri.parse('$socketServiceUrl');

  void addChannel(String trId) {
    channelMap[trId] = WebSocketChannel.connect(buildSocketUri(trId));
  }

  void addData(String urlKey, Object data) {
    channelMap[urlKey]!.sink.add(jsonEncode(data));
  }

  List<MapEntry<String, WebSocketChannel>> mapToList() {
    List<MapEntry<String, WebSocketChannel>> list = [];
    channelMap.forEach((key, value) => list.add(MapEntry(key, value)));
    return list;
  }
}
