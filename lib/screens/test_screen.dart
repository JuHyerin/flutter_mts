import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mts/providers/stock_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestScreen extends StatefulWidget {

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  late final StockSocket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket = StockSocket(['005930', '033180']);
  }


  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, WebSocketChannel>> list = socket.mapToList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('MTS'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: list.map((e) {
              return StockStreamWidget(trId: e.key, socket: e.value);
            }).toList(),
          ),
        )
    );
  }
}
class StockStreamWidget extends StatelessWidget {
  final String trId;
  final WebSocketChannel socket;
  StockStreamWidget({required this.trId, required this.socket});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: socket.stream,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            children: [
              Text(
                '${snapshot.data}'
                /*snapshot.hasData
                  ? '${snapshot.data}'[0] == '0' || '${snapshot.data}'[0] == '1'
                    ? '${snapshot.data}'
                    : jsonDecode(snapshot.data)["header"]
                  : ''*/
              ),
              ElevatedButton(
                  onPressed: () {
                    socket.sink.add(jsonEncode({
                      "header": {
                        // "appkey": api.appKey,
                        // "appsecret": api.secretKey,
                        "content-type": "utf-8",
                        "approval_key": "93fba692-6041-4e19-9939-07bdae320979",
                        "custtype": "P",
                        "tr_type": "1"
                      },
                      "body": {
                        "input": {
                          "tr_id": "H0STASP0",
                          "tr_key": trId
                        }
                      }
                    }));
                  },
                  child: const Text('add'))
            ],
          ),
        );
      },
    );
  }

}
