import 'package:flutter/material.dart';

class CheckValue extends StatefulWidget {
  const CheckValue({super.key});

  @override
  State<CheckValue> createState() => _CheckValueState();
}

class _CheckValueState extends State<CheckValue> {
  bool _isChecked = false;
  final bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
            },
            child: Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 1.5),
              ),
              child: _isChecked
                  ? Center(
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.orange),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(child: Text('Incluir 1 Simuc')),
          const SizedBox(width: 50),
          InkWell(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
            },
            child: Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 1.5)),
              child: _isChecked
                  ? Center(
                      child: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                    ))
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(child: Text('Incluir lote')),
        ],
      ),
    );
  }
}
