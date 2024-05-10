
import 'package:flutter/material.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/services/app_services.dart';

class AppProvider extends ChangeNotifier {
  final _service = AppServices();

  //CashFlow variable
  List<CashFlowModel> _cashFlowData = [];
  List<CashFlowModel> get cashFlowData => _cashFlowData;

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

}
