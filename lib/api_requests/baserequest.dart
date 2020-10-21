import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseRequest {
  String baseUrl = 'http://10.0.2.2:8000/';

  Future<List> fetch(String url) async {
    try {
      final response = await http.get('$baseUrl$url');

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
