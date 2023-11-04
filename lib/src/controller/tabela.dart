import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/src/controller/table_controller.dart';

class TabelaController extends ChangeNotifier {
  fetch() {
    print('Dados atualizados da tabela');
    notifyListeners();
  }
}