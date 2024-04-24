import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practise_ui/constant/server_url.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String _access_token = '';

  bool get isAuth {
    return _access_token.isNotEmpty;
  }

  Future<void> _authentication(String email, String password, String type) async {
    const url = "$PORT/users/login";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"email": email, "password": password}
        ),
      );
      final responseData = jsonDecode(res.body);
      if (responseData != null) {
        if (responseData['result']['access_token'].toString().isNotEmpty) {
          _access_token = responseData['result']['access_token'];
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) {
    _authentication(email, password, 'login');
  }
}