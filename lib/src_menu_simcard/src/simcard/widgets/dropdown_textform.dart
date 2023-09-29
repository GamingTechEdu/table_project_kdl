// import 'package:flutter/material.dart';
// import 'package:component_menu/package.dart';
//
// class DropDownTextForm extends StatefulWidget {
//   const DropDownTextForm({super.key});
//
//   @override
//   State<DropDownTextForm> createState() => _DropDownTextFormState();
// }
//
// class _DropDownTextFormState extends State<DropDownTextForm> {
//   // String selectedSupplierPlan = NltPlan[0];
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//       elevation: 1,
//       isDense: true,
//       isExpanded: true,
//       icon: const Icon(Icons.keyboard_arrow_down_outlined),
//       focusColor: Colors.transparent,
//       borderRadius: BorderRadius.circular(5),
//       items: costumerList.map((costumer) {
//         return DropdownMenuItem<String>(
//           value: costumer,
//           child: Text(costumer),
//         );
//       }).toList(),
//       onChanged: (value) {
//         selectedCostumer = value!;
//       },
//     );
//   }
// }
