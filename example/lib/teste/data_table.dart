import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './data_table_widget.dart';
import './item_model.dart';

class DataTableRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<ItemModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          DataTableWidget(items: itemModel.items),
          TextButton(onPressed: (){}, child: Text('teste'))
        ],
      ),
    );
  }
}
