import 'package:flutter/material.dart';

import 'datatable_header.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late List<DatatableHeader> _headers;


 @override
  void initState(){
   super.initState();

   _headers = [
     DatatableHeader(
         text: 'Cliente',
         value: 'cliente',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     ),
     DatatableHeader(
         text: 'N° Chipp(ICCID)',
         value: 'numerochip',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     ),
     DatatableHeader(
         text: 'Simcon',
         value: 'simcon',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     ),
     DatatableHeader(
         text: 'Fornecedor',
         value: 'fornecedor',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     ),
     DatatableHeader(
         text: 'N° da linha(MSISDN)',
         value: 'cliente',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     ),
     DatatableHeader(
         text: 'Cliente',
         value: 'cliente',
         show: true,
         sortable: true,
         textAlign: TextAlign.center,
     )
   ];
 }

 @override
 void dispose(){
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Adicione o código a ser executado quando o botão for pressionado
          },
          child: Text('Meu botão'),
        ),
      ),
    );
  }


}
