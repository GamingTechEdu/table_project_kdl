import 'package:flutter/material.dart';
import './item_model.dart';

class DataTableWidget extends StatelessWidget {
  final List<Item> items;

  DataTableWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Nome')),
        DataColumn(label: Text('Descrição')),
      ],
      rows: items.map((item) {
        return DataRow(cells: [
          DataCell(Text(item.name)),
          DataCell(Text(item.description)),
        ]);
      }).toList(),
    );
  }
}
