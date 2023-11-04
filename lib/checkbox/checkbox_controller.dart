import 'package:flutter/material.dart';

class CheckBoxController extends ChangeNotifier {
  bool value = false;

  chagestate() {
    value = !value;
    notifyListeners();
  }
}