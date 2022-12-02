import 'package:intl/intl.dart';

/* 숫자형 문자열 -> 절대값 */
String formatAbsoluteValue(String data) {
  num numberData = num.parse(data);
  return numberData < 0 ? '${numberData * -1}' : '$numberData';
}

/* 숫자형 문자열 -> 1000단위씩 콤마(,)로 끊기 */
String formatCurrency(String data) {
  num numberData = num.parse(data);
  final formatter = NumberFormat('###,###,###,###');
  return formatter.format(numberData);
}
