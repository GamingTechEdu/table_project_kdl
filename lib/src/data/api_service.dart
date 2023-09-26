import 'dart:convert';
import '../model/model.dart';
import 'package:http/http.dart' as http;


class ApiService {
   Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Map<String, dynamic>> source = jsonData.cast<Map<String, dynamic>>();
      return source;
    } else {
      throw Exception('Falha ao buscar os dados');
    }
  }
}


