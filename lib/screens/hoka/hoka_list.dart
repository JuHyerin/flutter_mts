import 'package:flutter/material.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:flutter_mts/utils/formatter_number.dart';
import 'package:get/get.dart';

class HokaList extends StatelessWidget {
  final double listItemHeight = 40.0;
  final String hokaTag;
  final String cntgTag;
  HokaList({required this.hokaTag, required this.cntgTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var hokaController = Get.find<StockDataController>(tag: hokaTag);
      var cntgController = Get.find<StockDataController>(tag: cntgTag);

      if (hokaController.stockData.value == '' || cntgController.stockData.value == '') {
        return const CircularProgressIndicator();
      } else {
        KisStockPurchase hoka = KisStockPurchase.parse(hokaController.stockData.value);
        KisStockCntg cntg = KisStockCntg.parse(cntgController.stockData.value);
        return Column(
          children: [
            /* Ask Price */
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: hoka.getAskPriceRestQuantityMap().map((e) {
                        return Row(
                          children: [
                            Expanded(flex:1, child: Container(color: Colors.blue, height: listItemHeight, child: Text(e.value),)),
                            Expanded(
                              flex:1,
                              child:
                              e.key == cntg.stockCurPrice
                                  ? Container(
                                height: listItemHeight,
                                decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
                                child: Text(formatCurrency(e.key)),
                              )
                                  : Container(
                                height: listItemHeight,
                                child: Text(formatCurrency(e.key)),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(color: Colors.grey, child: Text('container'),)
                )
              ],
            ),
            /* Bid Price */
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(color: Colors.grey, child: Text('container'),)
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: hoka.getBidPriceRestQuantityMap().map((e) {
                          return Row(
                            children: [
                              Expanded(
                                flex:1,
                                child:
                                e.key == cntg.stockCurPrice
                                    ? Container(
                                  height: listItemHeight,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
                                  child: Text(formatCurrency(e.key)),
                                )
                                    : Container(
                                  height: listItemHeight,
                                  child: Text(formatCurrency(e.key)),
                                ),
                              ),
                              Expanded(flex:1, child: Container(color: Colors.red, height: listItemHeight, child: Text(e.value))),
                            ],
                          );
                        }).toList()
                    )
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}
