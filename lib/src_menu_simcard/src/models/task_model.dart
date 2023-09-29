import 'package:intl/intl.dart';

import '../../package.dart';

class TaskModel{
  String? idCostumer;
  String? idSimcard;
  String? idSimcon;
  String? idLine;
  String  idIP;
  String? idSupplier;
  String? idSlot;
  String  idObservations;
  String? supplierType;
  String? idPlan;
  String? idDateActi;
  String? idDateinsta;
  String? idApn;

  TaskModel({
    this.idCostumer,
    this.idSimcard,
    this.idSimcon,
    this.idLine,
    this.idIP = "",
    this.idSupplier,
    this.idSlot,
    this.idObservations = "",
    this.supplierType,
    this.idPlan,
    this.idDateActi,
    this.idDateinsta,
    this.idApn,
  });


  // bool validateFields() {
  //   RegExp datePattern = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  //
  //   if (idCostumer == null || idCostumer!.isEmpty) {
  //     return false;
  //   }
  //   if (idSimcard == null || idSimcard!.isEmpty) {
  //     return false;
  //   }
  //   if (idSimcon == null || idSimcon!.isEmpty) {
  //     return false;
  //   }
  //   if (idLine == null || idLine!.isEmpty) {
  //     return false;
  //   }
  //   if (!datePattern.hasMatch(idDateActi!)) {
  //     return false;
  //   }
  //   print('Passei pela validação');
  //   return true;
  // }

  Map<String, dynamic> toJson() {
    // if (!validateFields()) {
    //   throw Exception("Pelo menos um dos campos não é válido.");
    // }

    return {
      "idCostumer": idCostumer,
      "idSimcard": idSimcard,
      "idSimcon": idSimcon,
      "idLine": idLine,
      "idIP": idIP,
      "idSupplier": idSupplier,
      "idSlot": idSlot,
      "observations": idObservations,
      "supplierType": supplierType,
      "idPlan": idPlan,
      "idDateActi": idDateActi,
      "idDateinsta": idDateinsta,
      "idApn": idApn,
    };
  }


}

List<String> costumerList = [
  'Selecione um Cliente',
  'ILUMINA SP',
  'GUARULHOS LUZ'
];

List<String> NltPlan = [
  '300MB COMPARTILHADO',
  '600MB COMPARTILHADO'
];

List<String> ArqiaPlan = [
  'IOT GO+ 300MB',
  'IOT GO+ 600MB'
];
