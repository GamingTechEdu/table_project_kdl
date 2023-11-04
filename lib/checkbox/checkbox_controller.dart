import 'package:flutter/material.dart';

class CheckBoxController extends ChangeNotifier {
  bool value = false;

  void chagestate() {
    value = !value;
    notifyListeners();
  }
}