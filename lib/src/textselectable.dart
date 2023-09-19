import 'package:flutter/material.dart';
import 'datatable_header.dart';

class SelectableTextWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final DatatableHeader header;
  final TextStyle? style;

  SelectableTextWidget({
    this.style,
    required this.data,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      "${data[header.value]}",
      style: style,
    );
  }
}



// class SelectableTextWidget extends StatelessWidget {
//   final Map<String, dynamic> text;
//   final TextStyle style;
//   final DatatableHeader header;
//
//   SelectableTextWidget({
//     required this.header,
//     required this.text,
//     required this.style,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SelectableText(
//       "${text[header.text]}",
//       style: style,
//     );
//   }
// }
//
// class DatatableHeader {
//   final String text;
//
//   DatatableHeader({required this.text});
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Texto Selecionável em Flutter'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SelectableTextWidget(
//                 text: {'text': 'Este é um texto selecionável em Flutter.'},
//                 header: DatatableHeader(text: 'text'),
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   printTextValue(); // Função para imprimir o valor do texto
//                 },
//                 child: Text('Imprimir Valor do Texto'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void printTextValue() {
//     // Acessa o valor de text e imprime
//     final textValue = 'Valor do Texto: ${SelectableTextWidget(text: {'text': 'Este é um texto selecionável em Flutter.'}, header: DatatableHeader(text: 'text'), style: TextStyle(fontSize: 18.0),).text['text']}';
//     print(textValue);
//   }
// }
//
//

