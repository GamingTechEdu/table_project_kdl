import 'package:flutter/material.dart';
import './date_picker.dart';

class Date extends StatelessWidget {

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController1 = TextEditingController();

  Date({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DatePicker(
              text: 'Data Ativação',
              controller: _dateController,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: DatePicker(
              text: 'Data Instalação',
              controller: _dateController1,
            ),
          )
        ],
      ),
    );
  }
}
