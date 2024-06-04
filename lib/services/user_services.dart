
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
      String url = '$PORT/app/delete-money-account/$idAccountWallet';
      final uri = Uri.parse(url);
      final res = await http.delete(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
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

  Future<Map<String, dynamic>> getAllExpenseRecordByAccountWalletServices(String accessToken, String id, String time)async{
    Map<String, dynamic> result = {};
    try{
      String url = '$PORT/app/expense-record/money-account/$id/$time';
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
  Future<Map<String, dynamic>> getAllExpenseRecordForNoteHistoryServices(String accessToken, String time)async{
    Map<String, dynamic> result = {};
    try{
      String url = '$PORT/app/expense-record/history/$time';
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
        result = {'errors': 'Thời gian không hợp lệ'};
      }
    }catch(e){
      throw Exception('Error when fetching $e');
    }
    return result;
  }

  Future<Map<String, dynamic>>getMeService(String accessToken)async{
    Map<String, dynamic> result = {'result':''};
    try{
      final uri = Uri.parse(getMeApi);
      final res = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if(res.statusCode == 200){
        final jsonData = jsonDecode(res.body);
        result = {'result': jsonData['result']};
      }
    }catch(e){
      throw Exception('Error while get me $e');
    }
    return result;
  }
  Future<Map<String, dynamic>> updateMeService(Map<String, dynamic> dataToUpdate, String accessToken)async{
    Map<String, dynamic> result= {};
    final uri = Uri.parse(updateMeApi);
    try{
      final res = await http.patch(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(dataToUpdate)
      );
      print(res.body);
      if(res.statusCode == 200){
        result = {
          'status': '200',
          'result': 'Cập nhật thành công'
        };
      }else {
        result = {
          'status': '403',
          'result': 'Cập nhật không thành công'
        };
      }
    }catch(e){
      throw Exception('fail to update me $e');
    }
    return result;
  }

  Future<Map<String, dynamic>> updateExpenseRecordServices(Map<String, dynamic> dataToUpdate, String accessToken)async{
    Map<String, dynamic> result = {};

    try{
      final uri = Uri.parse(updateExpenseRecordApi);
      final res = await http.patch(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(dataToUpdate)
      );
      if(res.statusCode == 200){
        result = {
          'status': '200',
          'result': 'Cập nhật thành công'
        };
      }else {
        result = {
          'status': '403',
          'result': 'Cập nhật không thành công'
        };
      }
    }catch(e){
      throw Exception(e);
    }
    return result;
  }
  Future<Map<String, dynamic>> deleteExpenseRecordService(String accessToken, String idExpenseRecord)async{
    Map<String, dynamic> result ={};
    try{
      String url = '$PORT/app/delete-expense-record/$idExpenseRecord';
      final uri = Uri.parse(url);
      final res = await http.delete(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if(res.statusCode == 200){
        result = {
          'status': '200',
          'result': 'Xóa bản ghi thành công'
        };
      }else {
        result = {
          'status': '403',
          'result': 'Xóa bản ghi không thành công'
        };
      }
    }catch(e){
      throw Exception('Error while delete expense record $e');
    }
    return result;
  }

  Future<bool> addSpendingLimitService(String accessToken, Map<String, dynamic> dataToPass)async{
    bool result = false;
    try{
      final uri = Uri.parse(postSpendingLimitApi);
      final res = await http.post(
        uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(dataToPass)
      );
      if(res.statusCode == 200){
        result = true;
      }else {
        result = false;
      }
    }catch(e){
      throw Exception(e);
    }
    return result;
  }
  Future<Map<String, dynamic>> getSpendingLimitService(String accessToken, String idSpendingLimit)async{
    Map<String, dynamic> result ={};
    try{
      String url = '$PORT/app/spending-limit/$idSpendingLimit';
      final uri = Uri.parse(url);
      final res = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if(res.statusCode == 200){
        Map<String, dynamic> jsonResult = jsonDecode(res.body);
        result = {
          'status': '200',
          'result': jsonResult['result'],
        };
      }else {
        result = {
          'status': '403',
          'result': {}
        };
      }
    }catch(e){
      throw Exception('Error while delete expense record $e');
    }
    return result;
  }

}