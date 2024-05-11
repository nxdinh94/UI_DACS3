
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/services/app_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/share_prefercence_key.dart';

class AppProvider extends ChangeNotifier {
  final _service = AppServices();

  //CashFlow variable
  List<CashFlowModel> _cashFlowData = [];
  List<CashFlowModel> get cashFlowData => _cashFlowData;

  //CashFlowCate variable
  Map<String, dynamic> _cashFlowCateData = {};
  Map<String, dynamic> get cashFlowCateData => _cashFlowCateData;


  //call api and save to cache
  Future<void> saveCashFlowApi() async {
    notifyListeners();
    final data = await _service.getAllCashsFlow();
    await CashFlowModel.saveCashFlow(data);
    notifyListeners();
  }
  // get data from cache
  Future<void> getAllCashFlowCache() async{
    notifyListeners();
    _cashFlowData = await CashFlowModel.getCashFlow();
    notifyListeners();
  }

  Future<void> saveCashFlowCateApi()async{
    notifyListeners();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final data = await _service.getCashFlowCateService();
    pref.setString(cashFlowCategoriesKey, jsonEncode(data));
    notifyListeners();
  }
  Future<void> getAllCashFlowCateCache() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();

    notifyListeners();
    final String? data = pref.getString(cashFlowCategoriesKey);
    if(data!= null){
      _cashFlowCateData = jsonDecode(data);
    }else {
      _cashFlowCateData = {};
    }
    notifyListeners();
  }



}
