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

  Map<String, double> _filteredSpendingDataForPieChartHomePage = {};
  Map<String, double> get filteredSpendingDataForPieChartHomePage => _filteredSpendingDataForPieChartHomePage;

  Map<String, double> _filteredRevenueDataForPieChartHomePage = {};
  Map<String, double> get filteredRevenueDataForPieChartHomePage => _filteredRevenueDataForPieChartHomePage;

  List<CollumChartModel> _filteredColumnChartDataHomePage = [];
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

  Future<void> getExpenseRecordForChartProvider(String url)async{
    isLoading = true;
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = await chartServices.getExpenseRecordForChartService(accessToken, url);
    //"result": {
    //         "spending_money": [],
    //         "revenue_money": []
    //     }
    if(result['status'] == '200'){
      List<dynamic> dataSpendingMoneyToMap = [];
      List<dynamic> dataRevenueMoneyToMap = [];
      _expenseRecordForChart = result;
      dataSpendingMoneyToMap = result['result']['spending_money'];
      dataRevenueMoneyToMap = result['result']['revenue_money'];
      await filterDataForChartProvider(dataSpendingMoneyToMap, dataRevenueMoneyToMap);
      isLoading = false;
    }
    notifyListeners();
  }
  Future<void> filterDataForChartProvider(List<dynamic>dataSpendingMoneyToMap,List<dynamic> dataRevenueMoneyToMap)async{
    double revenueMoneyCount = 0;
    double spendingMoneyCount = 0;

    _filteredSpendingDataForPieChartHomePage = {};
    _totalSpendingMoney = 0;

    _filteredRevenueDataForPieChartHomePage = {};
    _totalRevenueMoney = 0;

    _filteredColumnChartDataHomePage = [];

    if(dataSpendingMoneyToMap.isEmpty && dataRevenueMoneyToMap.isEmpty){
      _filteredColumnChartDataHomePage = [];
      return;
    }

    if(dataSpendingMoneyToMap.isNotEmpty){
      for (var e in dataSpendingMoneyToMap) {
      // Ensure result is a map
        _filteredSpendingDataForPieChartHomePage[e['parent_name']] = double.parse(e['total_money'][r'$numberDecimal'] as String);
        spendingMoneyCount += double.parse(e['total_money'][r'$numberDecimal'] as String);
      }
      _totalSpendingMoney = spendingMoneyCount;
      _filteredColumnChartDataHomePage.add(CollumChartModel(2, _totalSpendingMoney, chartCollumn2));
    }else {
      //if dataSpendingMoneyToMap == []
      _filteredSpendingDataForPieChartHomePage = {};
      _totalSpendingMoney = 0;
      // value == 0
      _filteredColumnChartDataHomePage.add(CollumChartModel(2, _totalSpendingMoney, chartCollumn2));
    }
    
    if(dataRevenueMoneyToMap.isNotEmpty){
      for(var e in dataRevenueMoneyToMap){
        _filteredRevenueDataForPieChartHomePage[e['parent_name']] = double.parse(e['total_money'][r'$numberDecimal'] as String);
        revenueMoneyCount += double.parse(e['total_money'][r'$numberDecimal']);
      }
      _totalRevenueMoney = revenueMoneyCount;
      _filteredColumnChartDataHomePage.add(CollumChartModel(1, _totalRevenueMoney, chartCollumn1));
    }else {
      //if dataRevenueMoneyToMap==[]
      _filteredRevenueDataForPieChartHomePage = {};
      _totalRevenueMoney = 0;
      //value == 0
      _filteredColumnChartDataHomePage.add(CollumChartModel(1, _totalRevenueMoney, chartCollumn1));
    }
    notifyListeners();
  }

}