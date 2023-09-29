import 'package:component_menu/package.dart';
import 'package:flutter/material.dart';

typedef OnOutput = void Function(TaskModel);

enum OnSelectedValue { nlt, arqia }

class GlobalConfig{
  static void showPopupSucess(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Cadastrado com sucesso!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {

                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  static void showPopupErrorStatus(context, response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Erro ao enviar os dados. Status Code: ${response.statusCode}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }
  static void showPopupErrors(context, e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Erro ao fazer a solicitação HTTP: $e'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  static final formKey = GlobalKey<FormState>();
  static const SizedBox formVerticalSpace = SizedBox(height: 10);
  static const SizedBox formHorizontalSpace = SizedBox(width: 50);
  static const SizedBox formHorizontalSpace20 = SizedBox(width: 10);
}