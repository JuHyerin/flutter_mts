import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mts/providers/stock_api.dart';
import 'package:flutter_mts/screens/common/stock_layout.dart';
import 'package:flutter_mts/screens/hoka/hoka_screen.dart';
import 'package:flutter_mts/store/stock_data_controller.dart';
import 'package:flutter_mts/store/token_controller.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  StockApi().getSocketAccessToken().then((value) {
    Get.put(TokenController(socketAccessToken: value));

    /* 장마감 후, 사용하는 test data */
    Get.put(StockDataController.forTest(
      '005930^113623^0^62200^62300^62400^62500^62600^62700^62800^62900^63000^63100^62100^62000^61900^61800^61700^61600^61500^61400^61300^61200^252233^224104^115585^189849^68316^112528^58137^108668^153184^94242^71917^112412^130025^146167^184671^262948^297805^277523^174113^205363^1376846^1862944^0^0^0^0^282713^-61900^5^-100.00^6556519^0^-30^0^0^0'
    ),tag: 'H0STASP0_005930');
    Get.put(StockDataController.forTest(
      '005930^123501^61000^5^-1600^-2.56^61501.31^62500^62500^60900^61000^60900^10^7525074^462801972700^11825^29231^17406^50.66^4811780^2437537^1^0.33^45.25^090004^5^-1500^090004^5^-1500^123323^2^100^20221202^20^N^228235^100806^797127^1735492^0.13^11018503^68.29^0^^62500^005930^123501^60900^5^-1700^-2.72^61501.31^62500^62500^60900^61000^60900^2^7525076^462802094500^11826^29231^17405^50.66^4811782^2437537^5^0.33^45.25^090004^5^-1600^090004^5^-1600^123323^3^0^20221202^20^N^228225^100814^797117^1735510^0.13^11018503^68.29^0^^62500'
    ),tag: 'H0STCNT0_005930');

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark()
      ),
      home: StockLayout()
    );
  }
}
