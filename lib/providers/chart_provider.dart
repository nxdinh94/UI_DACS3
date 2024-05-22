import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/services/chart_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/share_prefercence_key.dart';
import '../models/collum_chart_model.dart';
class ChartProvider with ChangeNotifier, DiagnosticableTreeMixin{
  final chartServices = ChartServices();

  Map<String, dynamic> _expenseRecordForChart = {};
  Map<String, dynamic> get expenseRecordForChart => _expenseRecordForChart;

  bool isLoading = false;

  final Map<String, double> _filteredSpendingDataForPieChartHomePage = {};
  Map<String, double> get filteredSpendingDataForPieChartHomePage => _filteredSpendingDataForPieChartHomePage;

  final Map<String, double> _filteredRevenueDataForPieChartHomePage = {};
  Map<String, double> get filteredRevenueDataForPieChartHomePage => _filteredRevenueDataForPieChartHomePage;

  final List<CollumChartModel> _filteredColumnChartDataHomePage = [];
  List<CollumChartModel> get filteredColumnChartDataHomePage => _filteredColumnChartDataHomePage;

  //in homePage
  double _totalSpendingMoney = 0;
  double get totalSpendingMoney => _totalSpendingMoney;
  // in homePage
  double _totalRevenueMoney = 0;
  double get totalRevenueMoney => _totalRevenueMoney;


  Future<String> getAccessToken()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Get token['refresh_token','refresh_token']
    String tokenString = pref.getString(userDataKey) as String;
    Map<String, dynamic> tokenDecoded  = jsonDecode(tokenString);
    return tokenDecoded['access_token'];
  }

  Future<void> getExpenseRecordForChartProvider(String time)async{
    isLoading = true;
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = await chartServices.getExpenseRecordForChartService(accessToken, time);
    if(result.isNotEmpty){
      _expenseRecordForChart = result;
    }
    await filterDataForChartProvider();
    isLoading = false;
    notifyListeners();
  }
  Future<void> filterDataForChartProvider()async{
    double revenueMoneyCount = 0;
    double spendingMoneyCount = 0;
    List<dynamic> dataSpendingMoneyToMap = expenseRecordForChart['result']['spending_money'];
    List<dynamic> dataRevenueMoneyToMap = expenseRecordForChart['result']['revenue_money'];
    if(dataSpendingMoneyToMap.isNotEmpty){
      for (var e in dataSpendingMoneyToMap) {
      // Ensure result is a map
        _filteredSpendingDataForPieChartHomePage[e['parent_name']] = double.parse(e['total_money'][r'$numberDecimal'] as String);
        spendingMoneyCount += double.parse(e['total_money'][r'$numberDecimal'] as String);
      }
      _totalSpendingMoney = spendingMoneyCount;
      _filteredColumnChartDataHomePage.add(CollumChartModel(2, totalSpendingMoney, chartCollumn2));
    }else {
      // value == 0
      _filteredColumnChartDataHomePage.add(CollumChartModel(2, totalSpendingMoney, chartCollumn2));
    }

    if(dataRevenueMoneyToMap.isNotEmpty){
      for(var e in dataRevenueMoneyToMap){
        _filteredRevenueDataForPieChartHomePage[e['parent_name']] = double.parse(e['total_money'][r'$numberDecimal'] as String);
        revenueMoneyCount += double.parse(e['total_money'][r'$numberDecimal']);
      }
      _totalRevenueMoney = revenueMoneyCount;
      _filteredColumnChartDataHomePage.add(CollumChartModel(1, totalRevenueMoney, chartCollumn1));

    }else {
      //value == 0
      _filteredColumnChartDataHomePage.add(CollumChartModel(1, totalRevenueMoney, chartCollumn1));

    }
    notifyListeners();
  }

}