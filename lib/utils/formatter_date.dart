/* yyyymmdd -> [yyyy, mm, dd] */
List<int> stringToDateArray(String data) {
  int year = int.parse(data.substring(0, 4));
  int month = int.parse(data.substring(4, 6));
  int day = int.parse(data.substring(6, 8));

  return [year, month, day];
}
