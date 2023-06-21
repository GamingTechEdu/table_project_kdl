import 'package:flutter/material.dart';
import './export_form.dart';

class ComponentForm extends StatefulWidget {
  const ComponentForm({super.key});

  @override
  State<ComponentForm> createState() => _ComponentFormState();
}

class _ComponentFormState extends State<ComponentForm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView(
            children: [
              Select(
                text: "Cliente",
                list: const [
                  "ILUMINA SP",
                  "BRASILUZ SCS-SP",
                  "BRASILUZ MAUÁ-SP",
                  "BRASILUZ TERESINA-PI",
                  "BRASILUZ BARRA DO GARÇA-MT",
                  "BRASILUZ DUTRA-MA",
                  "BRASILUZ SBC-SP",
                  "TERWAN PM SANTO ANDRÉ-SP",
                ],
              ),
              TextInput(
                text: "Número do chip(ICCID)",
              ),
              SimcomIP(),
              TextInput(
                text: "Número da linha(MSISDN)",
              ),
              CheckValue(),
              Select(
                text: "Fornecedor",
                list: const [
                  "Datelo",
                  "Arqia",
                ],
              ),
              SensorDimmer(),
              TextInput(
                lines: 3,
                text: "Observações",
              ),
            ],
          ),
        ));
  }
}

