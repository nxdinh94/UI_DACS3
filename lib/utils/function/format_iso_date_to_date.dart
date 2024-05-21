import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate);

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}