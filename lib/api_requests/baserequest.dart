import 'dart:convert';
import 'package:dbmonitor/redux/globalvariables.dart';
import 'package:http/http.dart' as http;

class BaseRequest {
  String baseUrl = 'http://10.0.2.2:8000/';

  Future<List> fetch(String url) async {
    if (GlobalVariables.connectionString == null ||
        GlobalVariables.connectionString == "") {
      return List();
    }

    try {
      final response = await http.post(
        '$baseUrl$url',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(GlobalVariables.connectionString),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
