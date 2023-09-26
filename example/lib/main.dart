import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/export_table.dart';
import 'package:provider/provider.dart';
import 'package:projeto_kdl_flutter/src/data/teste_notifier.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider(
      create: (BuildContext context) {ApiNotifier();},
      child: InteractiveDataTableView(),
  )));
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: InteractiveDataTableView(),
//   ));
// }









