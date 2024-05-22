import 'package:intl/intl.dart';

String showTheDayOFTheWeek(String date) {
  String result = 'Invalid date';
  DateTime dateToDateTime = DateTime.parse(date); // convert date to dateime
  String dayOfTheWeekOfItem = DateFormat('EEEE').format(dateToDateTime);
  final dateSplited = date.split('-'); //[yyyy, mm , dd]
  final String transformDay = dateSplited[2];

  DateTime currentDateTime = DateTime.now();
  final currentDay = currentDateTime.day; //int

  if (currentDay - int.parse(transformDay) == 0) {
    return result = 'Hôm nay';
  } else if (currentDay - int.parse(transformDay) == 1) {
    return result = 'Hôm qua';
  } else {
    result = dayOfTheWeekOfItem.toLowerCase();
  }

  switch (result) {
    case 'monday':
      return 'Thứ hai';
    case 'tuesday':
      return 'Thứ ba';
    case 'wednesday ':
      return 'Thứ tư';
    case 'thursday ':
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