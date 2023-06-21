import 'package:flutter/material.dart';

class SimucAplication extends StatefulWidget {
  final List<String> list;

  const SimucAplication({super.key, required this.list});

  @override
  State<SimucAplication> createState() => _SimucAplicationState();
}

class _SimucAplicationState extends State<SimucAplication> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: DropdownButtonFormField(
        focusColor: Colors.transparent,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            label: const Text('Fornecedor',
                style: TextStyle(color: Colors.black, fontSize: 25)),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        isExpanded: true,
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: null,
        onChanged: (n) {},
      ),
    );
  }
}
