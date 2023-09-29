import 'package:component_menu/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_menu/src/common/simcard_focusnode.dart';

class DateTextForm extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String labelText;
  final Function(String)? onChanged;

  const DateTextForm({
    Key? key,
    this.onChanged,
    this.focusNode,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  _DateTextFormState createState() => _DateTextFormState();
}

class _DateTextFormState extends State<DateTextForm> {
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        focusNode: widget.focusNode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9/]'),
          ),
          LengthLimitingTextInputFormatter(10),
        ],
          validator: (value) {
            if (!dateRegex.hasMatch(value!)) {
              return 'Formato Inválido\nUse dd/mm/aaaa';
            }
            return null;
          },
        // onChanged: (value){
        //   widget.onChanged!(value);
        // },
        controller: widget.controller,
        readOnly: false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
