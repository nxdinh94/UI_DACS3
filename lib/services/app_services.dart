import 'dart:convert';

import 'package:practise_ui/constant/server_url.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:http/http.dart' as http;

class AppServices{

  Future<List<CashFlowModel>> getAllCashsFlow() async {
    // Assuming you have a class named CashFlowModel to represent your data
    List<CashFlowModel> cashFlows = [];
    try {
      const url = '$PORT/app/get-cash-flow'; // Assuming SERVER_URL is defined in server_url.dart
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        final dynamic data = json.decode(response.body);
        cashFlows = List<CashFlowModel>.from(data['data'].map((e) {
          return CashFlowModel(id: e['_id'], iconPath: e['icon'], name: e['name'], isChosen: e['isChosen']);
        }));
        return cashFlows;
      } else {
        throw Exception('Failed to load cash flows');
      }
    } catch (e) {
      // If an error occurs, print the error message and return an empty list.
      print('Error fetching cash flows: $e');
      return cashFlows;
    }
  }
}
