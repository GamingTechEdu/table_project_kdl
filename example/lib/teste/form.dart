import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './item_model.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addItem(BuildContext context) {
    final name = _nameController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      final itemModel = Provider.of<ItemModel>(context, listen: false);
      itemModel.addItem(Item(name, description));

      _nameController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        ElevatedButton(
          onPressed: () => _addItem(context),
          child: Text('Adicionar Item'),
        ),
      ],
    );
  }
}
