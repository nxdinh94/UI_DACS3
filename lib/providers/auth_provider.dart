import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:practise_ui/constant/key.dart';
import 'package:practise_ui/constant/server_url.dart';
import 'package:http/http.dart' as http;
import 'package:practise_ui/utils/jwt.dart';

class AuthProvider extends ChangeNotifier {
  String _access_token = '';
  int _isVerify = -1;

  bool get isAuth {
    return _access_token.isNotEmpty;
  }

  int get isVerify {
    return _isVerify;
  }

  void checkVerify(Map<String, dynamic> decoded_authorization) {
    if (decoded_authorization.isNotEmpty) {
      _isVerify = decoded_authorization['verify'];
    }
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
          final _decoded_authorization = await verifyToken(
              token: _access_token,
              secretOrPublicKey: JWT_SECRET_ACCESS_TOKEN
          );
          checkVerify(_decoded_authorization);
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