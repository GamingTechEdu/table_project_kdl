import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  static Future<RxList<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final RxList<Map<String, dynamic>> source =  RxList<Map<String, dynamic>>.from(jsonData);
      return source;
    } else {
      throw Exception('Falha ao buscar os dados');
    }
  }
}
