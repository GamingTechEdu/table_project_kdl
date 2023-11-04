import 'package:projeto_kdl_flutter/src/controller/table_controller.dart';

class Tabela {
  final TableController tableController;

  Tabela(this.tableController);

  void atualizarTabela() {
    tableController.fetch();
  }
}