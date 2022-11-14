import 'package:flutter/material.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/providers/socket_controller.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class ControllerTestScreen extends StatefulWidget {
  final List<String> trKeys = ['005930', '033180'];
  final String serviceCd = 'H0STASP0';

  @override
  _ControllerTestScreenState createState() => _ControllerTestScreenState();
}

class _ControllerTestScreenState extends State<ControllerTestScreen> {
  late SocketController socketController;

  @override
  void initState() {
    super.initState();
    socketController = SocketController(
      serviceCd: widget.serviceCd,
      keys: widget.trKeys,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, WebSocketChannel>> list = socketController.mapToList();

    return Scaffold(
        appBar: AppBar(
          /*leading: ElevatedButton(
              onPressed: () => setState(() {
                socketController.addChannel('006400');
              }),
              child: const Text('ADD')),*/
          title: const Text('MTS'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: socketController
                .mapToList()
                .map((e) => StockStreamWidget(tag: '${widget.serviceCd}_${e.key}'))
                .toList(),
          ),
        )
    );
  }
}

class StockStreamWidget extends StatelessWidget {
  late String tag;
  StockStreamWidget({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    /* data store 에서 Getx 로 data 뿌리기 */
    return GetX<StockDataController>(
      tag: tag,
      builder: (controller) {
        if (controller.stockData == '') {
          return CircularProgressIndicator();
        } else {
          KisStockPurchase data = KisStockPurchase.parse(controller.stockData.value);
          return Container(
              child: Column(
                children: data.bidPriceList.map((e) => Text(e)).toList(),
              )
          );
        }
      },
    );
  }
}
