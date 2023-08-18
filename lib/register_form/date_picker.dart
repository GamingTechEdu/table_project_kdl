import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const DatePicker({
    Key? key,
    required this.text,
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
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formattedDate = formatter.format(picked);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.orange,
      cursorHeight: 25,
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(text,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        suffixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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


