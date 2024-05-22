import 'dart:convert';

import '../constant/server_url.dart';
import 'package:http/http.dart' as http;

class ChartServices{
  Future<Map<String, dynamic>> getExpenseRecordForChartService (String accessToken, String time) async{
    Map<String, dynamic> result = {};
    final uri = Uri.parse('$PORT/app/expense-record-for-statistics/$time');
    try{
      final res = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        result = jsonDecode(res.body);
      }else if(res.statusCode == 401){
        result['result'] = jsonDecode('Vui lòng đăng nhập lại');
      }

    }catch(e){
      print(e);
    }
    return result;
  }
}