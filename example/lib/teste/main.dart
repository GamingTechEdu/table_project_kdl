import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './data_table.dart';
import './form.dart';
import './item_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemModel(),
      child: MaterialApp(
        title: 'Tabela e Formulário',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Tabela e Formulário'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormWidget(),
              DataTableRowWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
