import 'package:component_menu/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_menu/src/common/simcard_focusnode.dart';
import 'package:component_menu/src/models/task_model.dart';
import 'package:component_menu/src/api/api_client.dart';

class IccidTextForm extends StatefulWidget {
  final Function(bool) callback;
  String? Function(String?)? validator;
  final TaskModel taskModel;
  final TextEditingController controller;

  IccidTextForm({super.key,
  required this.validator,
  required this.controller,
  required this.callback,
  required this.taskModel,
  });

  @override
  _IccidTextFormState createState() => _IccidTextFormState();
}

class _IccidTextFormState extends State<IccidTextForm> {
  final DataValidation dataValidation = DataValidation();
  String _inputNumber = "";
  bool _isLoading = false;
  bool _isInList = false;
  List<String> _numberList = [];


  @override
  void initState() {
    super.initState();
    _loadIccid();
  }

  Future<void> _loadIccid() async {
    try {
      final fetchedNames = await dataValidation.loadIccidFromApi();
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
          content: Text(_isInList ? 'O ICCID já está cadastrado!' : 'ICCID válido!'),
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
      focusNode: FocusNodes.iccidFocusNode,
      decoration: InputDecoration(
        labelText:  "Simcard(ICCID)",
        suffixIcon: (_inputNumber.isEmpty || _inputNumber.length != 20)
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
        LengthLimitingTextInputFormatter(20),
      ],
      validator: widget.validator,
      onChanged: (value) {
        setState(() {
          _inputNumber = value;
          if (value.isEmpty || value.length != 20) {
            _isLoading = false;
            _isInList = false;
          } else {
            checkNumberExistence();
          }
          if (value.length == 20) {
            FocusNodes.iccidFocusNode.unfocus();
            FocusScope.of(context).requestFocus(FocusNodes.simconFocusNode);
          }
        });
      },
      onSaved: (value){
        if(value!.isNotEmpty){
          widget.taskModel.idSimcard = value;
        }
      },
    );
  }
}
