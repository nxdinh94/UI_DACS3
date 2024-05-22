import 'package:intl/intl.dart';

String showTheDayOFTheWeek(String date) {
  String result = 'Invalid date';
  DateTime dateToDateTime = DateTime.parse(date); // convert date to dateime
  String dayOfTheWeekOfItem = DateFormat('EEEE').format(dateToDateTime);

  DateTime targetDate = DateTime(2023, 12, 31);

  DateTime currentDateTime = DateTime.now();
  int dayFromNowToTarget = targetDate.difference(currentDateTime).inDays;
  int dayFromSpcificDayToTarget = targetDate.difference(dateToDateTime).inDays;

  if (dayFromNowToTarget - dayFromSpcificDayToTarget == 0) {
    return result = 'Hôm nay';
  } else if (dayFromNowToTarget - dayFromSpcificDayToTarget == -1) {
    return result = 'Hôm qua';
  } else {
    result = dayOfTheWeekOfItem.toLowerCase();
  }

  switch (result) {
    case 'monday':
      return 'Thứ hai';
    case 'tuesday':
      return 'Thứ ba';
    case 'wednesday':
      return 'Thứ tư';
    case 'thursday':
      return 'Thứ năm';
    case 'friday':
      return 'Thứ sáu';
    case 'saturday':
      return 'Thứ bảy';
    case 'sunday':
      return 'Chủ nhật';

  }
  return result;
}