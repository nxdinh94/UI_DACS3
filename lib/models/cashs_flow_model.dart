import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constant/share_prefercence_key.dart';

class CashFlowModel{
  CashFlowModel({
    required this.id,
    required this.iconPath,
    required this.name,
    required this.isChosen,
  });
  final String id;
  final String iconPath;
  final String name;
  int isChosen;

  factory CashFlowModel.fromJson(Map<String, dynamic> json) => CashFlowModel(
    id: json['_id'],
    iconPath: json['icon'],
    name: json['name'],
    isChosen: json['isChosen'],
  );
  Map<String, dynamic> toJson() => {
    '_id': id,
    'icon': iconPath,
    'name': name,
    'isChosen': isChosen,
  };
// Save list of model objects to SharedPreferences
  static Future<void> saveCashFlow(List<CashFlowModel> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(cashFlow, itemsJson);
  }

// Get list of model objects from SharedPreferences
  static Future<List<CashFlowModel>> getCashFlow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson = prefs.getStringList(cashFlow);
    if (itemsJson == null) return [];
    return itemsJson.map((itemJson) => CashFlowModel.fromJson(jsonDecode(itemJson))).toList();
  }

}