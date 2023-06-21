import 'package:flutter/material.dart';

class SensorDimmer extends StatelessWidget {
  const SensorDimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DropdownButtonFormField(
              focusColor: Colors.transparent,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Sensor de Luz',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  child: Text('teste'),
                  value: 'Item1',
                ),
                DropdownMenuItem(child: Text('teste2'), value: 'Item2'),
              ],
              value: null,
              onChanged: (n) {},
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField(
              focusColor: Colors.transparent,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Dimmer',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  child: Text('teste'),
                  value: 'Item1',
                ),
                DropdownMenuItem(child: Text('teste2'), value: 'Item2'),
              ],
              value: null,
              onChanged: (n) {},
            ),
          )
        ],
      ),
    );
  }
}
