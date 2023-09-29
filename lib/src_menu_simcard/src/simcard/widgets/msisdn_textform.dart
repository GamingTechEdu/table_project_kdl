import 'package:component_menu/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_menu/src/common/simcard_focusnode.dart';
import 'package:component_menu/src/api/api_client.dart';


class MsisdnTextForm extends StatefulWidget {
  final Function(bool) callback;
  final TextEditingController controller;
  final TaskModel taskModel;
  String? Function(String?)? validator;

  MsisdnTextForm({super.key,
    required this.validator,
    required this.callback,
    required this.controller,
    required this.taskModel,
  });

  @override
  _MsisdnTextFormState createState() => _MsisdnTextFormState();
}

class _MsisdnTextFormState extends State<MsisdnTextForm> {
  final DataValidation dataValidation = DataValidation();

  String _inputNumber = "";
  bool _isLoading = false;
  bool _isInList = false;
  List<String> _numberList = [];

  @override
  void initState() {
    super.initState();
    _loadMsisn();
  }

  Future<void> _loadMsisn() async {
    try {
      final fetchedMsisdn = await dataValidation.loadMsisdnFromApi();
      setState(() {
        _numberList = fetchedMsisdn;
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
          content: Text(_isInList ? 'O MSISDN já está cadastrado!' : 'MSISDN válido!'),
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
      focusNode: FocusNodes.linhaFocusNode,
      decoration: InputDecoration(
        labelText:  "Linha(MSISDN)",
        suffixIcon: (_inputNumber.isEmpty || _inputNumber.length != 13)
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
        LengthLimitingTextInputFormatter(13),
      ],
      validator: widget.validator,
      onChanged: (value) {
        setState(() {
          _inputNumber = value;
          if (value.isEmpty || value.length != 13) {
            _isLoading = false;
            _isInList = false;
          } else {
            checkNumberExistence();
          }
          if (value.length == 13) {
            FocusNodes.linhaFocusNode.unfocus();
            FocusScope.of(context).requestFocus(FocusNodes.ipFocusNode);
          }
        });
      },
      onSaved: (value){
        if(value!.isNotEmpty){
          widget.taskModel.idLine = value;
        }
      },
    );
  }
}