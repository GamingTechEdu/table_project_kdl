import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository.dart';
import '../model/table_data_model.dart';

class TableRepositoryMock implements TableRepository{

  @override
  Future<RxList<Map<String, dynamic>>> getList() async{
    var value = await rootBundle.loadString('assets/data.json');
    List postJson = jsonDecode(value);
    final RxList<Map<String, dynamic>> source =  RxList<Map<String, dynamic>>.from(postJson);
    return source;
  }
}
