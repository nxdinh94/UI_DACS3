
String getCurrentMonth(){
  return DateTime.now().month.toString();
}

List<Map<String, dynamic>> rangeTimeData = [
  {'title': 'Toàn thời gian', 'value': 'all'},
  {'title': 'Tháng hiện tại', 'value': getCurrentMonth()},
  {'title': 'Tháng 1', 'value': '1'},
  {'title': 'Tháng 2', 'value': '2'},
  {'title': 'Tháng 3', 'value': '3'},
  {'title': 'Tháng 4', 'value': '4'},
  {'title': 'Tháng 5', 'value': '5'},
  {'title': 'Tháng 6', 'value': '6'},
  {'title': 'Tháng 7', 'value': '7'},
  {'title': 'Tháng 8', 'value': '8'},
  {'title': 'Tháng 9', 'value': '9'},
  {'title': 'Tháng 10', 'value': '10'},
  {'title': 'Tháng 11', 'value': '11'},
  {'title': 'Tháng 12', 'value': '12'},
];