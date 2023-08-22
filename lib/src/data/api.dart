import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataFetcher {
  final BuildContext context;

  DataFetcher(this.context);

  Future<void> fetchData(List<Map<String, dynamic>> _source, List<Map<String, dynamic>> _sourceFiltered, int _total, Function _resetData) async {
    try {
      final response = await http.get(Uri.parse('http://187.122.102.36:60060/simcards'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Map<String, dynamic>> source = jsonData.cast<Map<String, dynamic>>();
        _source = source;
        _sourceFiltered = List.from(_source);
        _total = _sourceFiltered.length;
        _resetData();
      } else {
        print('Erro na requisição: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro na requisição'),
              content: Text('Ocorreu um erro ao carregar os dados. Tente novamente mais tarde.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Erro na requisição: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro na requisição'),
            content: Text('Ocorreu um erro ao carregar os dados. Tente novamente mais tarde.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

