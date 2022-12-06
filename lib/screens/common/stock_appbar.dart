import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mts/models/kis_socket_response.dart';
import 'package:flutter_mts/screens/common/stock_tab.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:flutter_mts/utils/formatter_number.dart';
import 'package:get/get.dart';

class StockAppbar extends StatefulWidget {
  final bool isOpen;
  final TabController tabController;
  final String cntgTag;
  final Function changeTrKey;
  final String trKey;

  StockAppbar({
    required this.isOpen,
    required this.tabController,
    required this.cntgTag,
    required this.changeTrKey,
    required this.trKey
  });

  @override
  _StockAppbarState createState () => _StockAppbarState();
}

class _StockAppbarState extends State<StockAppbar> {

  /*
  * TODO
  * utils 분리
  * enum 처리
  * */
  Color getColorByCode(String data) {
    switch (data){
      case '1': // 상한
      case '2': // 상승
        return Colors.red;
      case '4': // 하한
      case '5': // 하락
        return Colors.blue;
      case '3': // 보합
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<StockDataController>(
      tag: widget.cntgTag,
      builder: (controller) {
        if (controller.stockData.value == '') {
          return const CircularProgressIndicator();
        } else {
          KisStockCntg cntg = KisStockCntg.parse(controller.stockData.value);
          final textColor = getColorByCode(cntg.prevDayVersusSign);

          if (widget.isOpen) { // 확장 Appbar
            return FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: TextField(
                              inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: widget.trKey,
                                  icon: const Icon(Icons.search, size: 20,)
                              ),
                              style: const TextStyle(fontSize: 14),
                              onSubmitted: (value) {
                                setState(() {
                                  // 종목코드 -> socket channel map 추가, tag 변경
                                  widget.changeTrKey(value);
                                });
                              },
                            )
                        ),
                        const Text('| 코스피', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    Text(formatCurrency(cntg.stockCurPrice), style: TextStyle(fontSize: 32, color: textColor),),
                    Text(formatCurrency(formatAbsoluteValue(cntg.prevDayVersus)), style: TextStyle(fontSize: 14, color: textColor)),
                    Text('${formatAbsoluteValue(cntg.prevDayContrastRatio)}%', style: TextStyle(fontSize: 14, color: textColor)),
                    Text('${cntg.accumulateVolume} 주', style: const TextStyle(fontSize: 14)),
                    StockTab(tabController: widget.tabController),
                  ]
              ),
            );
          } else { // 축소 Appbar
            return FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    Text('${cntg.MKSC_SHRN_ISCD} | 코스피', style: const TextStyle(fontSize: 14)),
                    Text(formatCurrency(cntg.stockCurPrice), style: TextStyle(fontSize: 32, color: textColor),),
                    StockTab(tabController: widget.tabController),
                  ]
              ),
            );
          }
        }
      },
    );
  }
}
