import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practise_ui/constant/share_prefercence_key.dart';
import 'package:practise_ui/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/key.dart';
import '../utils/jwt.dart';
class UserProvider extends ChangeNotifier{
  final userServices = UserServices();

  Future<Map<String, dynamic>> addMoneyAccount(Map<String, String> data)async{
    print(data);
    // Get instance SharedPreferences
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Get token['refresh_token','refresh_token']
    String tokenString = pref.getString(userDataKey) as String;
    Map<String, dynamic> tokenDecoded  = jsonDecode(tokenString);
    String accessToken = tokenDecoded['access_token'];
    String refreshToken = tokenDecoded['refresh_token'];
    final decodedAuthorization = await verifyToken(
        token: accessToken,
        secretOrPublicKey: JWT_SECRET_ACCESS_TOKEN
    );
    String userId = decodedAuthorization['user_id'];
    data['user_id'] = userId;
    Map<String, dynamic> result = await userServices.addAccountMoneyService(refreshToken, accessToken, data);
    return result;

  }
}