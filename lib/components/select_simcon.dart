import 'package:flutter/material.dart';

class SelectSimcon extends StatefulWidget {
  SelectSimcon({super.key});

  @override
  State<SelectSimcon> createState() => _SelectSimconState();
}

class _SelectSimconState extends State<SelectSimcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            label: const Text(
              'Selecione o SIMCON',
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
        items: [
          DropdownMenuItem(child: Text('teste'), value: 'Item1'),
          DropdownMenuItem(child: Text('teste2'), value: 'Item2'),
        ],
        value: null,
        onChanged: (n) {},
      ),
    );
  }
}
