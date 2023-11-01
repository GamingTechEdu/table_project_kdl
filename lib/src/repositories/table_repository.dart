import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../model/table_data_model.dart';

abstract class TableRepository{
  Future<List<Map<String, dynamic>>> getList();
}