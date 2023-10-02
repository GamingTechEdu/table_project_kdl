import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:projeto_kdl_flutter/export_table.dart';
import 'package:projeto_kdl_flutter/src/controller/controller.dart';// Importe o arquivo onde a classe ApiService está definida
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  test('Teste de fetchData', () async {
    final controller = Controller();

    // Mock da função fetchData na ApiService para retornar dados de teste
    ApiService.fetchData = () async {
      return RxList<Map<String, dynamic>>([
        {'id': 1, 'nome': 'Item 1'},
        {'id': 2, 'nome': 'Item 2'},
      ]);
    };

    await controller.fetchData();

    // Verifique se a variável source foi atualizada corretamente
    expect(controller.source.length, 2); // Deve conter 2 elementos

    // Verifique se os elementos da source estão corretos
    expect(controller.source[0]['id'], 1);
    expect(controller.source[0]['nome'], 'Item 1');
    expect(controller.source[1]['id'], 2);
    expect(controller.source[1]['nome'], 'Item 2');
  });
}
