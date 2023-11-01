import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:projeto_kdl_flutter/src/model/table_data_model.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository.dart';
import '../utils/api_utils.dart';

class TableRepositoryImp implements TableRepository {
  @override
  Future<List<Map<String, dynamic>>> getList() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
      final List<dynamic> jsonData = json.decode(response.body);
      final RxList<Map<String, dynamic>> source = RxList<Map<String, dynamic>>.from(jsonData.cast<Map<String, dynamic>>());
      return source;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
