import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:projeto_kdl_flutter/export_table.dart';
import 'package:projeto_kdl_flutter/src/controller/table_controller.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository_imp.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository_mock.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TableController>(
          create: (context) => TableController(TableRepositoryImp()),
        ),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: InteractiveDataTableView(),
      ),
    );
  }
}






