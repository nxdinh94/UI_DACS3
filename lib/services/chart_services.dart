import 'dart:convert';

import 'package:http/http.dart' as http;

class ChartServices{
  Future<Map<String, dynamic>> getExpenseRecordForChartService (String accessToken, String url) async{
    Map<String, dynamic> result = {};
    final uri = Uri.parse(url);
    try{
      final res = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        result = {
          'status': '200',
          'result' : jsonDecode(res.body)['result']
        };
      }else if(res.statusCode == 401){
        result = {
          'status': '401',
          'result' : 'Vui lòng đăng nhập lại'
        };
      }else {
        result = {
          'status': '404',
          'result' : 'Đã có lỗi xảy ra'
        };
      }

    }catch(e){
      print(e);
    }
    return result;
  }
}