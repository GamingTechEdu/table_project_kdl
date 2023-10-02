import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controller/controller.dart';

// final searchController = Get.put(Controller());
//
// List<Widget> buttonaction = [
//   TextButton.icon(
//     // onPressed: () {
//     //   showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //         title: Text("Novo SIMCARD"),
//     //         content: Container(
//     //           width: 100,
//     //           height: 100,
//     //           color: Colors.red,
//     //         ),
//     //         actions: [
//     //           TextButton(
//     //             onPressed: () {
//     //               Navigator.pop(context); // Fechar o AlertDialog
//     //             },
//     //             child: Text("Fechar"),
//     //           ),
//     //         ],
//     //       );
//     //     },
//     //   );
//     //   print('Novo Simcard');
//     // },
//     onPressed: () => {
//
//     },
//     icon: Icon(Icons.add),
//     label: Text("Novo SIMCARD"),
//   ),
//   TextButton.icon(
//     onPressed: () => {
//       print('Editar')
//     },
//     icon: Icon(Icons.edit),
//     label: Text("Editar"),
//   ),
//   TextButton.icon(
//     onPressed: () => {
//       print('Exportar')
//     },
//     icon: Icon(Icons.add_chart),
//     label: Text("Exportar"),
//   ),
//   TextButton.icon(
//     onPressed: () => {
//       // fetchData()
//     },
//     icon: Icon(Icons.refresh_sharp),
//     label: Text("Refresh"),
//   ),
//   TextButton.icon(
//     onPressed: () => {
//       print('Delete')
//     },
//     icon: const Icon(
//       Icons.delete,
//       color: Colors.red,
//     ),
//     label: const Text(
//       "Deletar",
//       style: TextStyle(
//         color: Colors.red,
//       ),
//     ),
//   ),
//   if (isSearch)
//     Container(
//       width: 300,
//       height: 40,
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: 'Pesquise por ' +
//                 _searchKey!
//                     .replaceAll(new RegExp('[\\W_]+'), ' ')
//                     .toUpperCase(),
//             prefixIcon: IconButton(
//                 icon: Icon(Icons.cancel),
//                 onPressed: () {
//                   setState(() {
//                     _isSearch = false;
//                   });
//                   initializeData();
//                 }),
//             suffixIcon: IconButton(
//                 icon: Icon(Icons.search), onPressed: () {})),
//         onSubmitted: (value) {
//           _filterData(value);
//         },
//       ),
//     ),
//   if (!_isSearch)
//     IconButton(
//         icon: Icon(Icons.search),
//         onPressed: () {
//           setState(() {
//             _isSearch = true;
//           });
//         })
// ];