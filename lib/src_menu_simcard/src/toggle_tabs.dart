import 'package:component_menu/src/called_filter_tabs.dart';
import 'package:component_menu/src/common/global_config.dart';
import 'package:flutter/material.dart';

class ToogleTabs extends StatefulWidget {
  final ValueChanged<CalledFilterTabs>? onTabSelect;
  dynamic activeStatus;

  ToogleTabs({required this.onTabSelect, this.activeStatus});

  @override
  ToogleTabsState createState() => ToogleTabsState();
}

class ToogleTabsState extends State<ToogleTabs> {
  List<bool> isSelected = [true, false];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    switch (widget.activeStatus["type"]) {
      case  'SIMUC':
        activeIndex = 0;
        break;
      case  'SIMCON':
        activeIndex = 1;
        break;
    }

    print(activeIndex);

    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minWidth: 350),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.02),
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          ToggleButtons(
            renderBorder: false,
            fillColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            selectedColor: Colors.black,
            splashColor: Colors.transparent,
            onPressed: (int index) {
              isSelected = [false, false];
              isSelected[index] = !isSelected[index];
              activeIndex = index;

              switch (activeIndex) {
                case 0:
                  widget.activeStatus["type"] = 'SIMUC';
                  break;
                case 1:
                  widget.activeStatus["type"] = 'SIMCON';
                  break;
              }
              setState(() {
                if (widget.onTabSelect != null) {
                  CalledFilterTabs calledFilterTabs = CalledFilterTabs(widget.activeStatus);
                  widget.onTabSelect!(calledFilterTabs);
                }
              });
            },
            isSelected: isSelected,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    GlobalConfig.formVerticalSpace,
                    const Text(
                      'SIMUC',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    markerSelected(0)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    GlobalConfig.formVerticalSpace,
                    const Text(
                      'SIMCON',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    markerSelected(1)
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            color: Colors.red,
            width: 45,
            height: 45,
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget markerSelected(index) {
    return Container(
      height: 4,
      width: 60,
      decoration: BoxDecoration(
          color: (activeIndex == index) ? Colors.blueAccent : Colors.transparent,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
    );
  }
}


