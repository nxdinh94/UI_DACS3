
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practise_ui/constant/server_url.dart';
class UserServices{

  Future<Map<String, dynamic>> addAccountMoneyService(String accessToken, Map<String, String> dataToPass)async{
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
      if(res.statusCode == 200){
        result =  {
          'status' : 200,
          'result' : jsonDecode(res.body)['result'],
        };
        return result;
      }else if(res.statusCode == 422){
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
  Future<Map<String, dynamic>> deleteAccountMoneyService(String idAccountWallet, String accessToken)async{
    Map<String, dynamic> result = {};
    try{
      final uri = Uri.parse(deleteAccountMoneyApi);
      final res = await http.delete(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
        body: jsonEncode(
          {'money_account_id': idAccountWallet}
        )
      );
      if(res.statusCode == 200){
        result = jsonDecode(res.body);
      }else if(res.statusCode == 401){
        result = jsonDecode(res.body);
      }
    }catch(e){
      result ={'result':e};
    }
    return result;
  }



  Future<Map<String,dynamic>> addExpenseRecordService(String accessToken, Map<String,String>data)async{
    Map<String, dynamic> result = {};
    try{
      final uri = Uri.parse(postExpenseRecord);
      final res = await http.post(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(data)
      );
      if(res.statusCode == 200){
        result = {
          'result': jsonDecode(res.body)['result'],
          'status': '200'
        };
      }else {
        return result = {
          'result': 'Thêm bản ghi không thành công',
          'status': '403'
        };
      }

    }catch(e){
      return result = {'error': e};
    }
    return result;
  }

  Future<Map<String, dynamic>> getAllExpenseRecordByAccountWalletServices(
      String accessToken, String id, String time //mm-yyyy
  )async{
    Map<String, dynamic> result = {};
    try{
      String url = '$PORT/app/expense-record/$id/$time';
      final uri = Uri.parse(url);
      final res = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        Map<String, dynamic> jsonData = jsonDecode(res.body);
        result = {'result' : jsonData['result']};
      }else if(res.statusCode == 422){
        result = {'errors': 'Ví không hợp lệ'};
      }
    }catch(e){
      throw Exception('Error when fetching $e');
    }
    return result;
  }

}