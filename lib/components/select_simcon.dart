import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  final String text;
  final List<String> list;

  Select({super.key, required this.list, required this.text});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: DropdownButtonFormField(
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        focusColor: Colors.transparent,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            label: Text(widget.text,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        // hint: Text(''),
        isExpanded: true,
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (n) {},
      ),
    );
  }
}
