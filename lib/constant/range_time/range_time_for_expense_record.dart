import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

DateTime currentDateTime() {
  return DateTime.now();
}
String getCurrentMonth(){
  return currentDateTime().month.toString();
}
String getCurrentYear(){
  return currentDateTime().year.toString();
}
int getPreviousMonth(int month){
  if(month == 12){
    return 1;
  }else {
    return month-1;
  }
}

bool isFullMonth(int month){
  bool result = false;
  // count how many days in previous month
  int amountDayOfMonth = daysInMonth(int.parse(getCurrentYear()), month);
  if(amountDayOfMonth == 30 || amountDayOfMonth == 28){
    result = false;
  }else if (amountDayOfMonth == 31 || amountDayOfMonth == 29){
    result = true;
  }
  return result;
}

String getMostRecentlyThirtyDays(){
  String result = '';
  DateTime thisDayOfPreviousMonth = DateTime(currentDateTime().year, currentDateTime().month -1 , currentDateTime().day);
  int previousMonth = thisDayOfPreviousMonth.month;
  bool isPreviousMonthFull = isFullMonth(previousMonth);
  //
  if(previousMonth == 2 && isPreviousMonthFull){
    DateTime resultDateTime = DateTime(thisDayOfPreviousMonth.year, thisDayOfPreviousMonth.month, thisDayOfPreviousMonth.day - 1 );
    result = DateFormat('dd-MM-yyyy').format(resultDateTime);
  }else if(previousMonth == 2 && !isPreviousMonthFull){
    DateTime resultDateTime = DateTime(thisDayOfPreviousMonth.year, thisDayOfPreviousMonth.month, thisDayOfPreviousMonth.day - 2 );
    result = DateFormat('dd-MM-yyyy').format(resultDateTime);
  }
  if(isPreviousMonthFull){
    DateTime resultDateTime = DateTime(thisDayOfPreviousMonth.year, thisDayOfPreviousMonth.month, thisDayOfPreviousMonth.day + 1 );
    result = DateFormat('dd-MM-yyyy').format(resultDateTime);
  }else {
    result = DateFormat('dd-MM-yyyy').format(thisDayOfPreviousMonth);
  }
  String now = DateFormat('dd-MM-yyyy').format(currentDateTime());
  //04-05-2024/03-06-2024
  return '$result/$now';
}

String getRangeTimeCurrentMonth(){
  String result = '';
  int thisMonth = currentDateTime().month;
  bool isThisMonthFull = isFullMonth(thisMonth);
  if(thisMonth == 2 && isThisMonthFull){
    result = '01-$thisMonth-${getCurrentYear()}/29-$thisMonth-${getCurrentYear()}';
  }else if(thisMonth == 2 && isThisMonthFull){
    result = '01-$thisMonth-${getCurrentYear()}/28-$thisMonth-${getCurrentYear()}';
  }
  if(isThisMonthFull){
    result = '01-$thisMonth-${getCurrentYear()}/31-$thisMonth-${getCurrentYear()}';

  }else {
    result = '01-$thisMonth-${getCurrentYear()}/30-$thisMonth-${getCurrentYear()}';
  }
  return result;
}
String getRangeTimePreviousMonth(){
  String result = '';
  int previous = currentDateTime().month - 1;
  bool isPreviousMonthFull = isFullMonth(previous);
  if(previous == 2 && isPreviousMonthFull){
    result = '01-$previous-${getCurrentYear()}/29-$previous-${getCurrentYear()}';
  }else if(previous == 2 && isPreviousMonthFull){
    result = '01-$previous-${getCurrentYear()}/28-$previous-${getCurrentYear()}';
  }
  if(isPreviousMonthFull){
    result = '01-$previous-${getCurrentYear()}/31-$previous-${getCurrentYear()}';

  }else {
    result = '01-$previous-${getCurrentYear()}/30-$previous-${getCurrentYear()}';
  }
  return result;
}
String getRangeTimeCurrentYear(){
  String result = '01-01-${getCurrentYear()}/31-12-${getCurrentYear()}';
  return result;
}
String getRangeTimePreviousYear(){
  int currentYear = int.parse(getCurrentYear());
  int previousYear = currentYear - 1;
  String result = '01-01-$previousYear/31-12-$previousYear';
  return result;
}

int getQuarter(int month){
  int result = 0;
  switch(month){
    case >=1 && <=3:
      result = 1;
    case >=4 && <=6:
      result = 2;
    case >=7 && <=9:
      result = 3;
    case >=10 && <=12:
      result = 4;
  }
  return result;
}

String getRangeTimeCurrentQuarter(){
  String result = '';
  int thisMonth = int.parse(getCurrentMonth());
  int quarter = getQuarter(thisMonth);
  if(quarter == 1){
    result = '01-01-${getCurrentYear()}/31-03-${getCurrentYear()}';
  }else if(quarter == 2){
    result = '01-04-${getCurrentYear()}/31-06-${getCurrentYear()}';

  }else if(quarter == 3){
    result = '01-07-${getCurrentYear()}/31-09-${getCurrentYear()}';

  }else{
    result = '01-10-${getCurrentYear()}/31-12-${getCurrentYear()}';
  }

  return result;
}
String getRangeTimePreviousQuarter(){
  String result = '';
  int thisMonth = int.parse(getCurrentMonth());

  int thisQuarter = getQuarter(thisMonth);
  int previousQuarter  = 0;
  int previousYear = int.parse(getCurrentYear()) - 1;
  //4th quarter of previous year
  if(thisQuarter == 1){
    result = '01-10-$previousYear/31-12-$previousYear';
    return result;
  }else {
    previousQuarter = thisQuarter -1;
  }

  if(previousQuarter == 1){
    result = '01-01-${getCurrentYear()}/31-03-${getCurrentYear()}';
  }else if(previousQuarter == 2){
    result = '01-04-${getCurrentYear()}/31-06-${getCurrentYear()}';

  }else if(previousQuarter == 3){
    result = '01-07-${getCurrentYear()}/31-09-${getCurrentYear()}';
  }
  return result;
}

List<Map<String, dynamic>> rangeTimeForExpenseRecord = [
  {'title': 'Toàn thời gian', 'value': ''},
  {'title': '30 ngày gần nhất', 'value': getMostRecentlyThirtyDays()},
  {'title': 'Tháng hiện tại', 'value': getRangeTimeCurrentMonth()},
  {'title': 'Tháng trước', 'value': getRangeTimePreviousMonth()},
  {'title': 'Quý này', 'value': getRangeTimeCurrentQuarter()},
  {'title': 'Quý trước', 'value': getRangeTimePreviousQuarter()},
  {'title': 'Năm nay', 'value': getRangeTimeCurrentYear()},
  {'title': 'Năm trước', 'value': getRangeTimePreviousYear()},

  {'title': 'Tùy chọn', 'value': '8'},
];