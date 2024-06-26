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

  Map<String, dynamic> _expenseRecordDataByAccountWallet = {};
  Map<String, dynamic> get expenseRecordDataByAccountWallet => _expenseRecordDataByAccountWallet;

  bool _isLoadingExpenseRecordDataByAccountWallet = true;
  bool get isLoadingExpenseRecordDataByAccountWallet => _isLoadingExpenseRecordDataByAccountWallet;

  Map<String, dynamic> _expenseRecordDataForNoteHistory = {};
  Map<String, dynamic> get expenseRecordDataForNoteHistory => _expenseRecordDataForNoteHistory;

  bool _isLoadingExpenseRecordDataForNoteHistory = true;
  bool get isLoadingExpenseRecordDataForNoteHistory => _isLoadingExpenseRecordDataForNoteHistory;


  Map<String, dynamic> _meData = {};
  Map<String, dynamic> get meData => _meData;

  bool _isGetAllSpendingLimitLoading = false;
  bool get isGetAllSpendingLimitLoading => _isGetAllSpendingLimitLoading;

  List<dynamic> _allSpendingLimit = [];
  List<dynamic> get allSpendingLimit => _allSpendingLimit;

  Map<String, dynamic> _specificSpendingLimit = {};
  Map<String, dynamic> get specificSpendingLimit => _specificSpendingLimit;



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

  Future<void> getAllExpenseRecordByAccountWalletProvider(String idAccountWallet, String time)async{
    _isLoadingExpenseRecordDataByAccountWallet = true;
    String accessToken = await getAccessToken();
    Map<String, dynamic> result =  await userServices.getAllExpenseRecordByAccountWalletServices(accessToken, idAccountWallet, time);
    if(result['result'] != null){
      _expenseRecordDataByAccountWallet =  result['result'];
      _isLoadingExpenseRecordDataByAccountWallet = false;
    }
    notifyListeners();
  }
  Future<void> getAllExpenseRecordForNoteHistoryProvider(String time)async{
    String accessToken = await getAccessToken();
    _isLoadingExpenseRecordDataForNoteHistory = true;
    Map<String, dynamic> result =  await userServices.getAllExpenseRecordForNoteHistoryServices(accessToken, time);
    if(result['result'] != null){
      _expenseRecordDataForNoteHistory =  result['result'];
      _isLoadingExpenseRecordDataForNoteHistory = false;
    }
    notifyListeners();
  }

  Future<void> getMeProvider ()async{
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = await userServices.getMeService(accessToken);
    if(result['result']!=''){
      _meData = result['result'];
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateMeProvider(Map<String, dynamic> dataToUpdate)async{
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = await userServices.updateMeService(dataToUpdate, accessToken);
    notifyListeners();
    return result;
  }
  Future<Map<String, dynamic>> updateExpenseRecordProvider(Map<String, dynamic> dataToUpdate)async{
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = await userServices.updateExpenseRecordServices(dataToUpdate, accessToken);
    notifyListeners();
    return result;
  }
  Future<Map<String, dynamic>> deleteExpenseRecordProvider(String idExpenseRecord)async{
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = {};
    result = await userServices.deleteExpenseRecordService(accessToken, idExpenseRecord);
    notifyListeners();
    return result;
  }

  Future<bool>addSpendingLimitProvider(Map<String, dynamic> dataToPass)async{
    String accessToken = await getAccessToken();
    bool result = false;
    result = await userServices.addSpendingLimitService(accessToken, dataToPass);
    notifyListeners();
    return result;
  }
  Future<Map<String, dynamic>>getSpecificSpendingLimitProvider(String idSpendingLimit)async{
    String accessToken = await getAccessToken();
    Map<String, dynamic> result = {};
    result = await userServices.getSpendingLimitService(accessToken, idSpendingLimit);
    if(result['status'] == '200'){
      _specificSpendingLimit = result['result'];
    }else {
      _specificSpendingLimit = {};
    }
    notifyListeners();
    return result;
  }
  Future<void>getAllSpendingLimitProvider()async{
    String accessToken = await getAccessToken();
    _isGetAllSpendingLimitLoading = true;
    Map<String, dynamic> result = {};
    result = await userServices.getAllSpendingLimitService(accessToken);
    if(result['result'].toString() != '{}'){
      _allSpendingLimit = result['result'];
      _isGetAllSpendingLimitLoading = false;
    }else{
      _allSpendingLimit = [];
    }
    notifyListeners();
  }
  Future<bool>changePasswordProvider(Map<String, String> dataToUpdate)async{
    String accessToken = await getAccessToken();
    bool result = false;
    result = await userServices.changePasswordSerive(accessToken, dataToUpdate);
    notifyListeners();
    return result;
  }
  Future<bool>deleteSpendingLimitProvider(String idSpendingLimit)async{
    String accessToken = await getAccessToken();
    bool result = false;
    result = await userServices.deleteSpendingLimitSerive(accessToken, idSpendingLimit);
    notifyListeners();
    return result;
  }
  Future<bool>updateSpendingLimitProvider(Map<String, dynamic> dataToUpdate)async{
    String accessToken = await getAccessToken();
    bool result = false;
    result = await userServices.updateSpendingLimitService(accessToken, dataToUpdate);
    notifyListeners();
    return result;
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('accountWalletList', accountWalletList));
  }

}