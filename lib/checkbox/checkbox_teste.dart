import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/checkbox/checkbox_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckBoxController(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: CheckboxTeste(),
          ),
        ),
      ),
    ),
  );
}

class CheckboxTeste extends StatefulWidget {
  const CheckboxTeste({super.key});

  @override
  State<CheckboxTeste> createState() => _CheckboxTesteState();
}

class _CheckboxTesteState extends State<CheckboxTeste> {
  final checkboxController = CheckBoxController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: checkboxController.value,
            onChanged: (value) {
              setState(() {
                checkboxController.chagestate();
              });
            }),
        ElevatedButton(
          onPressed: (){
            setState(() {
              checkboxController.chagestate();
            });
          },
          child: Text('Ativar checkbox'),
        )
      ],
    );
  }
}
