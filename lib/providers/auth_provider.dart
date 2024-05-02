import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:practise_ui/constant/key.dart';
import 'package:practise_ui/constant/server_url.dart';
import 'package:http/http.dart' as http;
import 'package:practise_ui/models/register_body.dart';
import 'package:practise_ui/utils/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _access_token = '';
  int _isVerify = -1;
  bool _isError = false;
  bool _isRegisterSuccess = false;
  Map<String, String> _errors = {};

  bool get isAuth {
    return _access_token.isNotEmpty;
  }

  Map<String, String> get errorsRegister {
    if (_errors.isNotEmpty) {
      final errors = _errors;
      _errors = {};
      return errors;
    }
    return {};
  }

  bool get isError {
    if (_isError) {
      _isError = false;
      return true;
    }
    return false;
  }

  bool get isRegisterSuccess {
    if (_isRegisterSuccess) {
      _isRegisterSuccess = false;
      return true;
    }
    return false;
  }

  int get isVerify {
    return _isVerify;
  }

  void checkVerify(Map<String, dynamic> decoded_authorization) {
    if (decoded_authorization.isNotEmpty) {
      _isVerify = decoded_authorization['verify'];
    }
  }

  Future<void> _authenticationLogin(String email, String password) async {
    const url = "$PORT/users/login";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          { "email": email, "password": password }
        ),
      );
      final responseData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (responseData['result']['access_token'].toString().isNotEmpty) {
          _access_token = responseData['result']['access_token'];
          // SharedPreferences: dùng để lưu vô bộ nhớ đệm
          final prefs = await SharedPreferences.getInstance();
          final userData = jsonEncode({ 'access_token': _access_token });
          await prefs.setString('userData', userData);

          final _decoded_authorization = await verifyToken(
              token: _access_token,
              secretOrPublicKey: JWT_SECRET_ACCESS_TOKEN
          );
          checkVerify(_decoded_authorization);
        }
      } else if (res.statusCode == 422) {
        _isError = true;
      }

      notifyListeners();
    } on SocketException catch (e) { // Catch specific exception types
      print('Socket Exception: $e');
      notifyListeners();
    } on HttpException catch (e) {
      print('HTTP Exception: $e');
      notifyListeners();
    } on FormatException catch (e) {
      print('Format Exception: $e');
      notifyListeners();
    } catch (e) {
      print('Unexpected Exception: $e');
      notifyListeners();
    }
  }

  Future<void> _authenticationRegister(RegisterReqBody reqBody) async {
    const url = "$PORT/users/register";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            { "name": reqBody.name, "email": reqBody.email,
              "password": reqBody.password, "confirm_password": reqBody.confirmPassword }
        ),
      );

      if (res.statusCode == 200) {
        _isRegisterSuccess = true;
      } else {
        final responseData = jsonDecode(res.body);
        for (var entry in responseData['errors'].entries) {
          _errors[entry.key] = entry.value['msg'];
        }
      }

      notifyListeners();
    } on SocketException catch (e) { // Catch specific exception types
      print('Socket Exception: $e');
      notifyListeners();
    } on HttpException catch (e) {
      print('HTTP Exception: $e');
      notifyListeners();
    } on FormatException catch (e) {
      print('Format Exception: $e');
      notifyListeners();
    } catch (e) {
      print('Unexpected Exception: $e');
      notifyListeners();
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    return true;
  }

  login(String email, String password) async {
    await _authenticationLogin(email, password);
  }

  register(RegisterReqBody reqBody) async {
    await _authenticationRegister(reqBody);
  }

  void logout() async {
    _access_token = '';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}