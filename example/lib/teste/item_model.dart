// No arquivo models/item_model.dart
import 'package:flutter/material.dart';

class ItemModel extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class Item {
  final String name;
  final String description;

  Item(this.name, this.description);
}
