import 'package:flutter/material.dart';
import './api_service.dart';

class ApiNotifier extends ChangeNotifier{
  List<Map<String, dynamic>> _sourceFiltered = [];
  List <Map<String, dynamic>> _source = [];
  int _total = 100;

  List<Map<String, dynamic>> get sourceFiltered => _sourceFiltered;
  List <Map<String, dynamic>> get source => _source;
  int get total => _total;

  final apiService = ApiService();

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> source = await apiService.fetchData();
        _source = source;
        print(_source);
        _sourceFiltered = List.from(_source);
        _total = _sourceFiltered.length;
        notifyListeners();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}

