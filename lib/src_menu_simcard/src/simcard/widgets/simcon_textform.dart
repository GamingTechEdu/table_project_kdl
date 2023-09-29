import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_menu/src/common/simcard_focusnode.dart';
import 'package:component_menu/src/models/task_model.dart';
import 'package:component_menu/src/kdl_controller.dart';
import 'package:component_menu/src/api/api_client.dart';


class SimconTextForm extends StatefulWidget {
  final TextEditingController controller;
  final TaskModel taskModel;
  final Function(bool) callback;
  String? Function(String?)? validator;

  SimconTextForm({super.key,
    required this.validator,
    required this.callback,
    required this.controller,
    required this.taskModel,
  });

  @override
  _SimconTextFormState createState() => _SimconTextFormState();
}

class _SimconTextFormState extends State<SimconTextForm> {
  final DataValidation dataValidation = DataValidation();
  String _inputNumber = "";
  bool _isLoading = false;
  bool _isInList = false;
  List<String> _numberList = [];

  @override
  void initState() {
    super.initState();
    _loadSimcon();
  }

  Future<void> _loadSimcon() async {
    try {
      final fetchedNames = await dataValidation.loadSimconFromApi();
      setState(() {
        _numberList = fetchedNames;
      });
    } catch (e) {
      print('Erro ao carregar nomes: $e');
    }
  }

  void checkNumberExistence() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isInList = _numberList.contains(_inputNumber);
        _isLoading = false;
        widget.callback(_isInList);
      });
    });
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validação'),
          content: Text(_isInList ? 'O Simcon já está cadastrado!' : 'Simcon válido!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: FocusNodes.simconFocusNode,
      decoration: InputDecoration(
        labelText:  "SIMCON",
        suffixIcon: (_inputNumber.isEmpty || _inputNumber.length != 7)
            ? null
            : _isLoading
            ? CircularProgressIndicator(
          strokeWidth: 3,
          strokeAlign: -5.0,
          backgroundColor: Colors.black12,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )
            : InkWell(
          onTap: () {
            if (!_isLoading) {
              showPopup();
            }
          },
          child: Icon(_isInList ? Icons.clear : Icons.check,
              color: _isInList ? Colors.red : Colors.green),
        ),
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(7),
      ],
      validator: widget.validator,
      onChanged: (value) {
        setState(() {
          _inputNumber = value;
          if (value.isEmpty || value.length != 7) {
            _isLoading = false;
            _isInList = false;
          } else {
            checkNumberExistence();
          }
          if (value.length == 7) {
            FocusNodes.simconFocusNode.unfocus();
            FocusScope.of(context).requestFocus(FocusNodes.linhaFocusNode);
          }
        });
      },
      onSaved: (value){
        if(value!.isNotEmpty){
          widget.taskModel.idSimcon = value;
        }
      },
    );
  }
}