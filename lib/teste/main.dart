import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'user_model.dart';
// import 'api.dart';
//
// class UserTable extends StatefulWidget {
//   @override
//   _UserTableState createState() => _UserTableState();
// }
//
// class _UserTableState extends State<UserTable> {
//   List<UserModel> _users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//   }
//
//   Future<void> _loadUsers() async {
//     final users = await ApiService.getUsers();
//     setState(() {
//       _users = users;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tabela de Usuários'),
//       ),
//       body: DataTable(
//         columns: const <DataColumn>[
//           DataColumn(label: Text('ID')),
//           DataColumn(label: Text('Nome')),
//           DataColumn(label: Text('Email')),
//         ],
//         rows: _users.map((user) {
//           return DataRow(
//             cells: <DataCell>[
//               DataCell(Text(user.id.toString())),
//               DataCell(Text(user.name)),
//               DataCell(Text(user.email)),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: UserTable(),
//   ));
// }

// void main() {
//   runApp(MyApp());
// }
//
// // Controlador do contador
// class CountController extends GetxController {
//   var count = 0.obs; // Variável observável
//
//   void increment() {
//     count.value++; // Incrementa o valor observável
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   final CountController _countController = Get.put(CountController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GetX Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() => Text('Count: ${_countController.count}')), // Observa a variável count
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _countController.increment(); // Chama o método increment do controlador
//               },
//               child: Text('Increment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class DataController extends GetxController {
  final _source = <Map<String, dynamic>>[].obs;
  final _sourceFiltered = <Map<String, dynamic>>[].obs;
  final _total = 0.obs;

  List<Map<String, dynamic>> get source => _source;
  List<Map<String, dynamic>> get sourceFiltered => _sourceFiltered;
  RxInt get total => _total;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://187.122.102.36:60060/simcards'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Map<String, dynamic>> source =
        jsonData.cast<Map<String, dynamic>>();

        _source.assignAll(source);
        _sourceFiltered.assignAll(source);
        _total.value = _sourceFiltered.length;
      } else {
        print('Erro na requisição: ${response.statusCode}');
        Get.dialog(
          AlertDialog(
            title: Text('Erro na requisição'),
            content: Text('Ocorreu um erro ao carregar os dados. Tente novamente mais tarde.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Erro na requisição: $e');
      Get.dialog(
        AlertDialog(
          title: Text('Erro na requisição'),
          content: Text('Ocorreu um erro ao carregar os dados. Tente novamente mais tarde.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final DataController _dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Total: ${_dataController.total}')),
            ElevatedButton(
              onPressed: () {
                _dataController.fetchData();
              },
              child: Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}
