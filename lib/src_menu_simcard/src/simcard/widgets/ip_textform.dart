import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_menu/src/models/task_model.dart';

import '../../common/simcard_focusnode.dart';

class IpTextForm extends StatefulWidget {
  final TextEditingController controller;
  final TaskModel taskModel;

  const IpTextForm({super.key,
    required this.controller,
    required this.taskModel
  });

  @override
  State<IpTextForm> createState() => _IpTextFormState();
}

class _IpTextFormState extends State<IpTextForm> {
  @override
  Widget build(BuildContext context) {
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    return  TextFormField(
      controller: widget.controller,
      focusNode: FocusNodes.ipFocusNode,
      decoration: InputDecoration(
        label: const Text(
            "IP"
        ),
        suffixIcon: isAndroid
            ? InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: const Icon(
            Icons.horizontal_split_rounded,
            color: Colors.black26,
            size: 26.0,
          ),
        ) : const SizedBox.shrink(),
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9./]'),
        ),
        LengthLimitingTextInputFormatter(16),
      ],
      onChanged: (value){
        if (value.length == 16) {
            FocusNodes.ipFocusNode.unfocus();
            FocusScope.of(context).requestFocus(FocusNodes.DateActiveFocusNode);
        }
      },
      onSaved: (value){
        if(value!.isNotEmpty){
          widget.taskModel.idIP = value;
        }
      },
    );
  }
}
