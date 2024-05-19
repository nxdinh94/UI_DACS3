import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practise_ui/constant/share_prefercence_key.dart';
import 'package:practise_ui/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/key.dart';
import '../utils/jwt.dart';
class UserProvider with ChangeNotifier, DiagnosticableTreeMixin{
  final userServices = UserServices();

  List<dynamic> _accountWalletList = [];
  List<dynamic> get accountWalletList => _accountWalletList;

  Future<String> getAccessToken()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Get token['refresh_token','refresh_token']
    String tokenString = pref.getString(userDataKey) as String;
    Map<String, dynamic> tokenDecoded  = jsonDecode(tokenString);
    return tokenDecoded['access_token'];
  }

  Future<Map<String, dynamic>> addMoneyAccount(Map<String, String> data)async{
    String accessToken = await getAccessToken();
    final decodedAuthorization = await verifyToken(
        token: accessToken,
        secretOrPublicKey: JWT_SECRET_ACCESS_TOKEN// key to decode
    );
    String userId = decodedAuthorization['user_id'];
    data['user_id'] = userId;
    notifyListeners();
    Map<String, dynamic> result = await userServices.addAccountMoneyService(accessToken, data);
    notifyListeners();
    return result;
  }
  Future<Map<String, dynamic>> updateMoneyAccount(Map<String, String> data)async{
    String accessToken = await getAccessToken();
    notifyListeners();
    Map<String, dynamic> result = await userServices.updateAccountMoneyService(accessToken, data);
    notifyListeners();
    return result;
  }
  Future<void> getAllAccountWallet()async{

    String accessToken = await getAccessToken();
    Map<String, dynamic> resultData = await userServices.getAllAccountMoneyService(accessToken);
    if(resultData['data']!= null){
      _accountWalletList =  resultData['data'];
    }else {
      _accountWalletList = [];
    }
    notifyListeners();
  }
  Future<Map<String, dynamic>> deleteAccountWall(String idAccountWallet)async{
    String accessToken = await getAccessToken();
    return await userServices.deleteAccountMoneyService(idAccountWallet, accessToken);
  }

  Future<Map<String, dynamic>> addExpenseRecordProvider(Map<String, String> dataToPass)async{
    Map<String, dynamic> result = {};
    String accessToken = await getAccessToken();
    result = await userServices.addExpenseRecordService(accessToken, dataToPass);
    return result;
  }




  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('accountWalletList', accountWalletList));
  }

}