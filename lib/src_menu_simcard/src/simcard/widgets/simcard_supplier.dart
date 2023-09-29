import 'package:flutter/material.dart';
import 'package:component_menu/package.dart';
import 'package:component_menu/src/common/global_config.dart';

class SimcardSupplier extends StatefulWidget {
  String? selectedValue;
  final Function(String)? onChanged, onChanged2;
  final String valueOne, valueTwo;
  final String titleOne, titleTwo;
  final String slotOne, slotTwo;
  final TaskModel taskModel;

  SimcardSupplier({
    this.onChanged,
    this.onChanged2,
    required this.selectedValue,
    required this.valueOne,
    required this.valueTwo,
    required this.titleOne,
    required this.titleTwo,
    required this.slotOne,
    required this.slotTwo,
    required this.taskModel,
  });

  @override
  State<SimcardSupplier> createState() => _SimcardSupplierState();
}

class _SimcardSupplierState extends State<SimcardSupplier> {
  String? plan;
  String? slot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: widget.valueOne,
              groupValue: widget.selectedValue,
              onChanged: (value) {
                setState(() {
                  widget.taskModel.idSupplier = value;
                  widget.taskModel.idSlot = widget.slotOne;
                  widget.selectedValue = value;
                  widget.onChanged!(value!);
                });
              },
            ),
            Text(widget.titleOne),
            GlobalConfig.formHorizontalSpace,
            Radio(
              value: widget.valueTwo,
              groupValue: widget.selectedValue,
              onChanged: (value) {
                setState(() {
                  widget.taskModel.idSupplier = value;
                  widget.taskModel.idSlot = widget.slotTwo;
                  widget.selectedValue = value;
                  widget.onChanged!(value!);
                });
              },
            ),
            Text(widget.titleTwo),
          ],
        ),

        if (widget.selectedValue != null && widget.selectedValue == "NLT")
          DropdownButtonFormField(
            elevation: 1,
            isDense: true,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            focusColor: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            hint: const Text("Selecione o Plano"),
            items: NltPlan.map((plan) {
              return DropdownMenuItem<String>(
                value: plan,
                child: Text(plan),
              );
            }).toList(),
            onChanged: (value) {
              // selectedCostumer = value!;
              widget.taskModel.idPlan = value;
              plan = value;
              widget.onChanged2!(value!);
            },
          ),
           GlobalConfig.formHorizontalSpace,
        if (widget.selectedValue != null && widget.selectedValue == "ARQIA")
          DropdownButtonFormField(
            elevation: 1,
            isDense: true,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            borderRadius: BorderRadius.circular(5),
            focusColor: Colors.transparent,
            hint: const Text("Selecione o Plano"),
            items: ArqiaPlan.map((plan) {
              return DropdownMenuItem<String>(
                value: plan,
                child: Text(plan),
              );
            }).toList(),
            onChanged:(value){
                widget.taskModel.idPlan = value;
                plan = value;
                widget.onChanged2!(value!);
            },
          ),
      ],
    );


  }
}
