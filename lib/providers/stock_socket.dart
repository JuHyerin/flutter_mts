import 'dart:convert';

// import 'package:web_socket_channel/io.dart';
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
    try{
      WebSocketChannel socket = WebSocketChannel.connect(buildSocketUri(trId));

      /* screen 에서 StreamBuilder로 Handler 추가하는 방법 몰라서 일단 여기에 추가 */
      socket.stream.listen((event) => print('[$trId] data>> ' + event.toString()),
          onError: (error) => print('[$trId] error>> '+error.toString()),
          onDone: () => print('====== ${trId} onDone ===== ')
      );
      channelMap[trId] = socket;
    } catch (e) {
      print(e.toString());
    }
  }

  void addData(String urlKey, Object data) {
    try{
      channelMap[urlKey]!.sink.add(jsonEncode(data));
    } catch(e) {
      print(e.toString());
    }

  }

  List<MapEntry<String, WebSocketChannel>> mapToList() {
    List<MapEntry<String, WebSocketChannel>> list = [];
    channelMap.forEach((key, value) => list.add(MapEntry(key, value)));
    return list;
  }
}
