import 'dart:convert';
import 'package:practise_ui/constant/server_url.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:http/http.dart' as http;

class AppServices{

  Future<List<CashFlowModel>> getAllCashsFlow() async {
    List<CashFlowModel> cashFlows = [];
    try {
      const url = getCashFlowApi;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        final dynamic data = json.decode(response.body);
        cashFlows = List<CashFlowModel>.from(data['data'].map((e) {
          return CashFlowModel(id: e['_id'], iconPath: e['icon'], name: e['name'], isChosen: e['isChosen']);
        }));
        return cashFlows;
      } else {
        throw Exception('Failed to load cash flows');
      }
    } catch (e) {
      // If an error occurs, print the error message and return an empty list.
      print('Error fetching cash flows: $e');
      return cashFlows;
    }
  }

  Future<Map<String, dynamic>> getCashFlowCateService()async{
    Map<String, dynamic> data = {};
    try{
      final uri = Uri.parse(getCashFlowCateApi);
      final res = await http.get(uri);
      if(res.statusCode == 200){
        final dynamic result = jsonDecode(res.body);
        data = result['result'];
      }else {
        throw Exception('Failed to load cash flows');
      }
    }catch(e){
      print('Error fetching: $e');
      return data;
    }
    return data;
  }
  Future<List<dynamic>> getAccountWalletTypeService()async{
    List<dynamic> data = [];
    try{
      final uri = Uri.parse(getAccountWalletTypeApi);
      final res = await http.get(uri);
      if(res.statusCode == 200){
        final result = jsonDecode(res.body);
        data = result['result'];
        return data;
      }else {
        throw Exception('Fail to load getAccountWalletTypeService');
      }
    }catch(e){
      print('Error while fetching $e');
    }
    return data;
  }

  Future<List<dynamic>> getBankService() async {
    List<dynamic> data = [];
    try {
      const url ="https://api.vietqr.io/v2/banks";
      var res = await http.get(Uri.parse(url));
      if(res.statusCode == 200) {
        final result = jsonDecode(res.body);
        data = result['data'];
        return data;
      } else {
        return data;
      }
    }catch(e){
      print('Error fetch bank $e');
    }
    return data;
  }


}
