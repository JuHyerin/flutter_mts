import 'package:flutter/material.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

List<String> trKeys = ['005930', '033180'];

class ControllerTestScreen extends StatefulWidget {

  @override
  _ControllerTestScreenState createState() => _ControllerTestScreenState();
}

class _ControllerTestScreenState extends State<ControllerTestScreen> {
  late final SocketController socketController;

  @override
  void initState() {
    super.initState();
    socketController = SocketController(
      serviceCd: 'H0STASP0',
      keys: trKeys,
    );
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
            children: socketController
                .mapToList()
                .map((e) => StockStreamWidget(channelSet: e))
                .toList(),
          ),
        )
    );
  }
}
class StockStreamWidget extends StatelessWidget {
  final MapEntry<String, WebSocketChannel> channelSet;
  StockStreamWidget({required this.channelSet});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: channelSet.value.stream,
      builder: (context, snapshot) {
        print(snapshot.toString());
        return Center(
          child: Text('${snapshot.data}'),
        );
      },
    );
  }

}
