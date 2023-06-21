import 'package:flutter/material.dart';

class SectorSubSector extends StatelessWidget {
  const SectorSubSector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              cursorColor: Colors.orange,
              cursorHeight: 25,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Setor',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: TextField(
              cursorColor: Colors.orange,
              cursorHeight: 25,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Sub-setor',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
