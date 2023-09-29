import 'package:component_menu/package.dart';
import 'package:component_menu/src/simcard/simcard_include.dart';
import 'package:component_menu/src/common/global_config.dart';
import 'package:component_menu/src/simcard/simcard_menu.dart';
import 'package:flutter/material.dart';
import 'package:component_menu/src/common/menu_button.dart';
import 'called_filter_tabs.dart';

class SimcardsManager extends StatefulWidget {
  final OnOutput onOutput;
  final EdgeInsets padding;
  final KdlController controller;

  const SimcardsManager({
    super.key,
    required this.onOutput,
    required this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  });

  @override
  State<SimcardsManager> createState() => _SimcardsManagerState();
}

class _SimcardsManagerState extends State<SimcardsManager> {
  MenuButtonType activeAction = MenuButtonType.simcardMenu;
  dynamic activeStatus = {'type': 'SIMCARD'};

  TaskModel? activeTaskModel;

  Widget buildView(){
    late Function result;

    switch(activeAction) {

      case MenuButtonType.simcardMenu:
        return SimcardMenu(
          onPressed: (value) {
            setState(() {
              activeAction = value;
              activeStatus = {'type': 'SIMCARD'};
            });
          },
        );

      case MenuButtonType.simcardInclude:
        return SimcardInclude(
          onOutput: widget.onOutput,
          controller: widget.controller,
          onBack: () {
            setState(() {
              activeAction = MenuButtonType.simcardMenu;
              activeStatus = {'type': 'SIMCARD'};
            });
          },
          taskModel: TaskModel(),
        );
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // if (activeAction == MenuButtonType.simcardMenu)
        //   ToogleTabs(
        //       onTabSelect: (CalledFilterTabs value) {
        //         setState(() {
        //           final activeMenu = value.status["type"]!;
        //           if (activeMenu == "SIMCARD") {
        //             activeAction = MenuButtonType.simcardMenu;
        //           }
        //         });
        //       },
        //       activeStatus: activeStatus
        //   ),
        if (activeAction == MenuButtonType.simcardMenu)
          SimcardMenu(onPressed: (value) {
            setState(() {
              activeAction = value;
              print(activeAction);
            });
          }),
        if (activeAction != MenuButtonType.simcardMenu) buildView(),
      ],
    );
  }
}
