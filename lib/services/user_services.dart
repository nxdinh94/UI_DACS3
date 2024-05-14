
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:practise_ui/constant/server_url.dart';
class UserServices{

  Future<Map<String, dynamic>> addAccountMoneyService(
    String refreshToken, String accessToken, Map<String, String> dataToPass
  )async{
    Map<String, dynamic> result = {};
    // print(dataToPass);
    // print(accessToken);
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
      }else {
        throw Exception(res.body);
      }
    }catch(e){
      print('Error handling addAccountMoney $e');
      return result = {'result': 'Tài khoản đã tồn tại'};

    }


    return result;
  }

}