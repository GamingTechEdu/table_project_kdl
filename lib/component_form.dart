import 'package:flutter/material.dart';
import './export_form.dart';


class ComponentForm extends StatefulWidget {

  const ComponentForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentForm> createState() => _ComponentFormState();
}

class _ComponentFormState extends State<ComponentForm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            Date(),
            TextInput(
              lines: 3,
              text: "Observações",
            ),
            Button(),
          ],
        ),
      ),
    );
  }
}


class TelaPrincipal extends StatelessWidget {
  final FormularioExterno formularioExterno = FormularioExterno();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Botão'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Abrir Formulário'),
          onPressed: () {
            formularioExterno.abrirFormulario(context);
          },
        ),
      ),
    );
  }
}


class FormularioExterno {
  void abrirFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Cadastrar SIMCARDS"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:[
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
                Date(),
                TextInput(
                  lines: 3,
                  text: "Observações",
                ),
                Button(),
              ],
            ),
          ),
        );
      },
    );
  }
}