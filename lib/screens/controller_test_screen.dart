import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mts/models/kis_socket_request_param.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/providers/stock_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

List<String> trKeys = ['005930', '033180'];

class ControllerTestScreen extends StatefulWidget {

  @override
  _ControllerTestScreenState createState() => _ControllerTestScreenState();
}

class _ControllerTestScreenState extends State<ControllerTestScreen> {
  late final SocketController socketController;
  late List<MapEntry<String, WebSocketChannel>> list;

  @override
  void initState() {
    super.initState();
    socketController = SocketController(
        serviceCd: 'H0STASP0',
        keys: trKeys
    );
    list = socketController.mapToList();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('MTS'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: list.map((e) =>
              StreamBuilder(
                stream: e.value.stream,
                builder: (context, snapshot) {
                  print(snapshot.toString());
                  return Center(
                    child: Text('${snapshot.data}'),
                  );
                },
              )).toList(),
          ),
        )
    );
  }
}
// class StockStreamWidget extends StatelessWidget {
//   final MapEntry<String, WebSocketChannel> channelSet;
//   StockStreamWidget({required this.channelSet});
//
//
//   @override
//   Widget build(BuildContext context) {
//     print('${channelSet.key}>> ${channelSet.value}');
//
//     return StreamBuilder(
//       stream: channelSet.value.stream,
//       builder: (context2, snapshot) {
//         print(snapshot.toString());
//         return Center(
//           child: Text('${snapshot.data}'),
//         );
//       },
//     );
//   }
//
// }
