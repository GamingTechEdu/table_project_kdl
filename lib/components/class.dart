import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DatePickerFormField extends StatelessWidget {
  final String labelText;

  final TextEditingController controller;

  const DatePickerFormField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = picked
          .toString(); // Atualiza o texto no controlador com a data selecionada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            suffixIcon: Icon(Icons.calendar_today),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
// child: DropdownButtonFormField(
// elevation: 0,
// icon: const Icon(Icons.keyboard_arrow_down_outlined),
// focusColor: Colors.transparent,
// decoration: InputDecoration(
// floatingLabelBehavior: FloatingLabelBehavior.always,
// focusedBorder: OutlineInputBorder(
// borderSide:
// BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
// borderRadius: BorderRadius.circular(10)),
// label: Text(widget.text,
// style: TextStyle(color: Colors.black, fontSize: 25),
// ),
// enabledBorder: OutlineInputBorder(
// borderSide:
// BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
// borderRadius: BorderRadius.circular(10)),
// border:
// OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
// // hint: Text(''),
// isExpanded: true,
// items: widget.list.map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (n) {},
// ),
// );
//

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DatePicker Demo',
      home: MyFormScreen(),
    );
  }
}

class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DatePickerFormField(
              labelText: 'Data',
              controller: _dateController,
            ),
            // Outros campos do formulário...
            ElevatedButton(
              onPressed: () {
                // Ação do botão de envio
                print('Data selecionada: ${_dateController.text}');
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
