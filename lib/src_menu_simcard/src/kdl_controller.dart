import 'package:component_menu/package.dart';
import 'package:flutter/cupertino.dart';

class KdlController{

  Future<List<LabelValue>> loadListSimucDropDown() async {
    print("KdlController-->loadListSimucDropDown");
    await Future.delayed(const Duration(seconds: 1));
    return [
      LabelValue<String>(label: "1234567890", value: "1234567890"),
      LabelValue<String>(label: "1234564569", value: "1234564569"),
      LabelValue<String>(label: "1234567896", value: "1234567896"),
      LabelValue<String>(label: "1234561236", value: "1234561236"),
      LabelValue<String>(label: "1234561237", value: "1234561237"),
      LabelValue<String>(label: "1234561238", value: "1234561238"),
      LabelValue<String>(label: "1234561285", value: "1234561285"),
    ];
  }

  final TextEditingController idSimcardController = TextEditingController();
  final TextEditingController idSimconController = TextEditingController();
  final TextEditingController idLineController = TextEditingController();
  final TextEditingController idIpController = TextEditingController();
  final TextEditingController idDateActiController = TextEditingController();
  final TextEditingController idDateInstaController = TextEditingController();
  final TextEditingController idObservationController = TextEditingController();

  void dispose() {
    idSimcardController.dispose();
    idSimconController.dispose();
    idLineController.dispose();
    idIpController.dispose();
    idDateActiController.dispose();
    idDateInstaController.dispose();
    idObservationController.dispose();
  }


}

