import 'package:flutter/material.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final List<String> items = [
    'ILUMINA SP',
    'ILUMINA SP2',
    'ILUMINA SP3',
    'ILUMINA SP4'
  ];

  String? selectedItem;
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Flutter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton(
                  value: selectedItem,
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue){
                    setState(() {
                      selectedItem = newValue;
                    });
                  }
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    // Faça algo com os dados do formulário, por exemplo, enviar para um servidor
                    print('Nome: $_name');
                    print('E-mail: $_email');
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormRegister(),
    );
  }
}



