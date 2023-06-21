import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String text;
  final int? lines;

  const TextInput({super.key, required this.text, this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        maxLines: lines,
        cursorColor: Colors.orange,
        cursorHeight: 25,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            label: Text(text,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
