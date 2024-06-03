
import 'package:intl/intl.dart';


String getCurrentDay(){
  String result = '';
  DateTime now = DateTime.now();
  result = DateFormat('dd-MM-yyyy').format(now);
  return result;
}

String getThisWeek(){
  String result = '';
  //get current datetime
  DateTime now = DateTime.now();
  DateTime startOfTheWeek = now.subtract(Duration(days: now.weekday -1 ));
  DateTime endOfTheWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

  String parseStartOfTheWeek = DateFormat('dd-MM-yyyy').format(startOfTheWeek);
  String parseEndOfTheWeek = DateFormat('dd-MM-yyyy').format(endOfTheWeek);

  result = '$parseStartOfTheWeek/$parseEndOfTheWeek';
  return result;
}

String getThisMonth(){
  String result = '';
  DateTime now = DateTime.now();
  int thisMonth = now.month;
  int thisYear = now.year;
  String dayOne = '01';
  int numberOfDayOfMonth = DateTime(thisYear, thisMonth + 1, 0).day;
  String startDayOfMonth = '$dayOne-$thisMonth-$thisYear';
  String endDayOfMonth = '$numberOfDayOfMonth-$thisMonth-$thisYear';
  result = '$startDayOfMonth/$endDayOfMonth';
  return result;
}

String getThisYear(){
  String result = '';
  DateTime now = DateTime.now();
  int thisYear = now.year;
  String firstDay = '01';
  String firstMonth = '01';
  String numberDayOfEndYear = '31';
  String startDayOfYear = '$firstDay-$firstMonth-$thisYear';
  String endDayOfYear = '$numberDayOfEndYear-12-$thisYear';
  result = '$startDayOfYear/$endDayOfYear';
  return result;
}


List<Map<String, dynamic>> rangeTimeHomePageChart = [
  {'title': 'Hôm nay', 'value': getCurrentDay()},
  {'title': 'Tuần này', 'value': getThisWeek()},
  {'title': 'Tháng này', 'value': getThisMonth()},
  {'title': 'Năm nay', 'value': getThisYear()},
  {'title': 'Toàn thời gian', 'value': 'all'},
];

