import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/checkbox/checkbox_controller.dart';
import 'package:provider/provider.dart';

class CheckboxTeste extends StatefulWidget {
  final CheckBoxController checkboxController;
  CheckboxTeste({required this.checkboxController, Key? key}) : super(key: key);

  @override
  State<CheckboxTeste> createState() => _CheckboxTesteState();
}

class _CheckboxTesteState extends State<CheckboxTeste> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: widget.checkboxController.value,
          onChanged: (value) {
            setState(() {
              widget.checkboxController.changeState();
            });
          },
        ),
      ],
    );
  }
}

