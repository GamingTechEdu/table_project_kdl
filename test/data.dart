import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_kdl_flutter/src/controller/table_controller.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository_imp.dart';

import 'package:projeto_kdl_flutter/src/repositories/table_repository_mock.dart';



import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
 // Importe a classe que você deseja testar

void main() {

  group('YourDataController tests', () {
    testWidgets('fetch method', (tester) async {
      // Inicialize o controlador
      final controller = Get.put(TableController(TableRepositoryImp()));

      // Chame o método fetch
      await controller.fetch();
      var lista = controller.source;
      print(lista);


      // Verifique se o estado foi atualizado
      expect(controller.isLoading, isFalse);
      // Adicione mais verificações conforme necessário
    });

    testWidgets('resetData method', (tester) async {
      // Inicialize o controlador
      final controller = Get.put(TableController(TableRepositoryImp()));

      // Chame o método resetData
      await controller.resetData();

      // Verifique se o estado foi atualizado
      expect(controller.isLoading, isFalse);
      // Adicione mais verificações conforme necessário
    });

    testWidgets('filterData method', (tester) async {
      // Inicialize o controlador
      final controller = Get.put(TableController(TableRepositoryImp()));

      // Chame o método filterData
      await controller.filterData("searchValue");

      // Verifique se o estado foi atualizado
      expect(controller.isLoading, isFalse);
      // Adicione mais verificações conforme necessário
    });
  });
}


