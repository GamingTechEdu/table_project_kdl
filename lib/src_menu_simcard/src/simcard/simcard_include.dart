import 'package:component_menu/package.dart';
import 'package:component_menu/botao_personalizado.dart';
import 'package:component_menu/src/api/api_client.dart';
import 'package:component_menu/src/simcard/widgets/date_textform.dart';
import 'package:flutter/material.dart';
import 'package:component_menu/src/common/tabbar_back.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class SimcardInclude extends StatefulWidget {
  final OnOutput onOutput;
  final VoidCallback onBack;
  final TaskModel taskModel;
  final EdgeInsets padding;
  final KdlController controller;

  const SimcardInclude({super.key,
  required this.onOutput,
  required this.onBack,
  required this.taskModel,
  required this.controller,
  this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  });

  @override
  State<SimcardInclude> createState() => _SimcardIncludeState();
}

class _SimcardIncludeState extends State<SimcardInclude> {
  String? selectedValue;
  String? plan;
  String? slot;
  String? apn;
  String? supplierType;
  final controller = KdlController();
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  String selectedCostumer = costumerList[0];
  String? costumer = '';
  bool isInListIccid = false;
  bool isInListSimcon = false;
  bool isInListMsisdn = false;

  void IsInListIccid(bool newValue) {
    isInListIccid = newValue;
  }

  void IsInListSimcon(bool newValue) {
    isInListSimcon = newValue;
  }

  void IsInListMsisdn(bool newValue) {
    isInListMsisdn = newValue;
  }

  String formatDate(String inputDate) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final date = inputFormat.parse(inputDate);
    return outputFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          TabBarBack(onBack: widget.onBack, title: "SIMCARD / Incluir"),
          Positioned(
            top: 45,
            bottom: 0,
            left: 0,
            right: 0,
            child: FutureBuilder(
              future: widget.controller.loadListSimucDropDown(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  return ListView(
                    children: [
                      Padding(
                        padding: widget.padding,
                        child: Form(
                          key: GlobalConfig.formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                elevation: 1,
                                isDense: true,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                focusColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                value: selectedCostumer,
                                items: costumerList.map((costumer) {
                                  return DropdownMenuItem<String>(
                                    value: costumer,
                                    child: Text(costumer),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                    selectedCostumer = value!;
                                },
                                validator: (value) {
                                  if (value == 'Selecione um Cliente') {
                                    return 'Por favor, selecione um cliente';
                                  }
                                  return null;
                                },
                              ),
                              GlobalConfig.formVerticalSpace,
                              IccidTextForm(
                                controller: controller.idSimcardController,
                                callback: IsInListIccid,
                                taskModel: widget.taskModel,
                                validator: (value){
                                  if(isInListIccid == true){
                                    return "Número do ICCID já cadastrado!";
                                  }
                                  if (value!.isEmpty) {
                                    return "Número do SIMCON obrigatório";
                                  }
                                  return null;
                                },
                                // simcard: simcard,
                              ),
                              GlobalConfig.formVerticalSpace,
                              SimconTextForm(
                                controller: controller.idSimconController,
                                callback: IsInListSimcon,
                                taskModel: widget.taskModel,
                                validator: (value){
                                  if(isInListSimcon == true){
                                    return "Número do SIMCON já cadastrado!";
                                  }
                                  if (value!.isEmpty) {
                                    return "Número do SIMCON obrigatório";
                                  }
                                  return null;
                                }
                              ),
                              GlobalConfig.formVerticalSpace,
                              MsisdnTextForm(
                                callback: IsInListMsisdn,
                                controller: controller.idLineController,
                                taskModel: widget.taskModel,
                                validator: (value){
                                  if(isInListMsisdn == true){
                                    return "Número do MSISDN já cadastrado!";
                                  }
                                  if (value!.isEmpty) {
                                    return "Número do MSISDN obrigatório";
                                  }
                                  return null;
                                },
                              ),
                              GlobalConfig.formVerticalSpace,
                              IpTextForm(
                                controller: controller.idIpController,
                                taskModel: widget.taskModel
                              ),
                              GlobalConfig.formVerticalSpace,
                              Row(
                                children: [
                                  DateTextForm(
                                    focusNode: FocusNodes.DateActiveFocusNode,
                                    controller: controller.idDateActiController,
                                    labelText: 'Data Ativação',
                                  ),
                                  GlobalConfig.formHorizontalSpace20,
                                  DateTextForm(
                                    controller: controller.idDateInstaController,
                                    labelText: 'Data Instalação',
                                  ),
                                ]
                              ),
                              GlobalConfig.formVerticalSpace,
                              SimcardSupplier(
                                 selectedValue: selectedValue,
                                 titleOne: "NLT",
                                 titleTwo: "ARQIA",
                                 slotOne: '1',
                                 slotTwo: '2',
                                 valueOne: "NLT",
                                 valueTwo: "ARQIA",
                                 taskModel: widget.taskModel,
                                onChanged: (value){
                                    selectedValue = value;
                                    if(selectedValue == "NLT"){
                                      slot = "1";
                                      supplierType = "VIVO";
                                      apn = "datelo.nlt.br";
                                    }else{
                                      slot = "2";
                                      supplierType = "TIM";
                                      apn = "kdl.br";
                                    }
                                   },
                                onChanged2: (value){
                                  plan = value;
                                },
                             ),
                              GlobalConfig.formVerticalSpace,
                              TextFormField(
                                maxLines: 2,
                                controller: controller.idObservationController,
                                decoration: const InputDecoration(
                                  label: Text('Observações'),
                                  contentPadding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
                                ),
                                onChanged: (value) => widget.taskModel.idObservations = value,
                              ),
                              GlobalConfig.formVerticalSpace,

                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: TextButton(
                                  onPressed: () async {
                                    if (GlobalConfig.formKey.currentState!.validate()) {
                                      GlobalConfig.formKey.currentState!.save();
                                      widget.onOutput(widget.taskModel);

                                      final formattedActivationDate = formatDate(controller.idDateActiController.text);
                                      final formattedInstallationDate = formatDate(controller.idDateInstaController.text);

                                      final task = TaskModel(
                                        idCostumer: selectedCostumer,
                                        idSimcard: controller.idSimcardController.text,
                                        idSimcon: controller.idSimconController.text,
                                        idLine: controller.idLineController.text,
                                        idIP: controller.idIpController.text,
                                        supplierType: supplierType,
                                        idSlot: slot,
                                        idPlan: plan,
                                        idSupplier: selectedValue,
                                        idObservations: controller.idObservationController.text,
                                        idDateActi: formattedActivationDate,
                                        idDateinsta: formattedInstallationDate,
                                        idApn: apn,
                                      );

                                      await DataRecordSimcard.recordSimcard(context, task);

                                      GlobalConfig.formKey.currentState!.reset();
                                      controller.idSimcardController.clear();
                                      controller.idSimconController.clear();
                                      controller.idLineController.clear();
                                      controller.idIpController.clear();
                                    }

                                  },
                                  child: const Text("Confirmar"),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
