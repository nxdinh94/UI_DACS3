
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practise_ui/constant/server_url.dart';
class UserServices{

  Future<Map<String, dynamic>> addAccountMoneyService(String refreshToken, String accessToken, Map<String, String> dataToPass)async{
    Map<String, dynamic> result = {};

    try{
      final res = await http.post(
        Uri.parse(postAddingAccountMoney),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
            dataToPass
        ),
      );
      if(res.statusCode == 200){
        result =  {
          'status' : 200,
          'result' : "Thêm tài khoản thành công"
        };
        return result;
      }else if(res.statusCode == 422){
        result =  {
          'status' : 422,
          'result' : "Tên tài khoản đã tồn tại"
        };
      }else if(res.statusCode == 401){
        result =  {
          'status' : 401,
          'result' : "Kết thúc phiên làm việc "
        };
      }else {
        throw Exception(res.body);
      }
    }catch(e){
      print('Error handling addAccountMoney $e');
      return result = {'result': 'Tài khoản đã tồn tại'};
    }
    return result;
  }
  Future<Map<String, dynamic>> updateAccountMoneyService(String accessToken, Map<String, String> dataToPass)async{
    Map<String, dynamic> result = {};

    try{
      final res = await http.patch(
        Uri.parse(updateAccountMoney),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
            dataToPass
        ),
      );
      print(res.body);

      if(res.statusCode == 200){
        result =  {
          'status' : 200,
          'result' : jsonDecode(res.body)['result'],
        };
        return result;
      }else if(res.statusCode == 422){
        print(res.body);
        result =  {
          'status' : 422,
          'result' : "Tài khoản đã tồn tại"
        };
      }else if(res.statusCode == 401){
        result =  {
          'status' : 401,
          'result' : "Kết thúc phiên làm việc "
        };
      }else {
        throw Exception(res.body);
      }
    }catch(e){
      print('Error handling addAccountMoney $e');
      return result = {'result': 'Tài khoản đã tồn tại'};
    }
    return result;
  }
  Future<Map<String, dynamic>> getAllAccountMoneyService(String accessToken)async{
    Map<String, dynamic> result = {};
    try{

      final uri = Uri.parse(getAllAccountWalletApi);
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        }
      );
      if(res.statusCode == 200){
        final resResult = jsonDecode(res.body);
        return result = {
          "data": resResult['result'],
        };
      }else {
        return result={
          'result':"Error fetching data"
        };
    }
    }catch(e){
      print('$e');
    }
    return result;
  }
}