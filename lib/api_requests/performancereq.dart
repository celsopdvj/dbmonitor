import 'dart:convert';

import 'package:dbmonitor/api_models/performancemodel.dart';
import 'package:http/http.dart' as http;

class PerformanceRequest {
  Future<List<PerformanceModel>> fetchPerformance({int minutes = 30}) async {
    try {
      final response =
          await http.get('http://10.0.2.2:8000/graph?minutes=$minutes');

      print("acessando api");

      if (response.statusCode == 200) {
        List retorno = jsonDecode(response.body);

        return retorno.map((el) {
          Map<String, dynamic> dado = el;
          return PerformanceModel.fromJson(dado);
        }).toList();
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
