import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';
import 'datatable_header.dart';
import './texteditable.dart';

class ResponsiveDatatable extends StatefulWidget {
  final bool showSelect;
  final List<DatatableHeader> headers;
  final List<Map<String, dynamic>>? source;
  final List<Map<String, dynamic>>? selecteds;
  final Widget? title;
  final List<Widget>? actions;
  final List<Widget>? footers;
  final Function(bool? value)? onSelectAll;
  final Function(bool? value, Map<String, dynamic> data)? onSelect;
  final Function(Map<String, dynamic> value)? onTabRow;
  final Function(dynamic value)? onSort;
  final String? sortColumn;
  final bool? sortAscending;
  final bool isLoading;
  final bool autoHeight;
  final bool hideUnderline;
  final bool commonMobileView;
  final bool isExpandRows;
  final List<bool>? expanded;
  final Widget Function(Map<String, dynamic> value)? dropContainer;
  final Function(Map<String, dynamic> value, DatatableHeader header)? onChangedRow;
  final Function(Map<String, dynamic> value, DatatableHeader header)? onSubmittedRow;
  final List<ScreenSize> reponseScreenSizes;
  final BoxDecoration? headerDecoration;
  final BoxDecoration? rowDecoration;
  final BoxDecoration? selectedDecoration;
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final TextStyle? selectedTextStyle;

  const ResponsiveDatatable({
    Key? key,
    this.showSelect = false,
    this.onSelectAll,
    this.onSelect,
    this.onTabRow,
    this.onSort,
    this.headers = const [],
    this.source,
    this.selecteds,
    this.title,
    this.actions,
    this.footers,
    this.sortColumn,
    this.sortAscending,
    this.isLoading = false,
    this.autoHeight = true,
    this.hideUnderline = true,
    this.commonMobileView = false,
    this.isExpandRows = true,
    this.expanded,
    this.dropContainer,
    this.onChangedRow,
    this.onSubmittedRow,
    this.reponseScreenSizes = const [
      ScreenSize.xs,
      ScreenSize.sm,
      ScreenSize.md
    ],
    this.headerDecoration,
    this.rowDecoration,
    this.selectedDecoration,
    this.headerTextStyle,
    this.rowTextStyle,
    this.selectedTextStyle,
  }) : super(key: key);

  @override
  _ResponsiveDatatableState createState() => _ResponsiveDatatableState();
}

class _ResponsiveDatatableState extends State<ResponsiveDatatable> {


  Widget mobileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: widget.selecteds!.length == widget.source!.length &&
              widget.source != null &&
              widget.source!.isNotEmpty,
          onChanged: (value) {
            if (widget.onSelectAll != null) widget.onSelectAll!(value);
          },
        ),
        PopupMenuButton(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const Text("SORT BY"),
            ),
            tooltip: "SORT BY",
            initialValue: widget.sortColumn,
            itemBuilder: (_) => widget.headers
                .where(
                    (header) => header.show == true && header.sortable == true)
                .toList()
                .map((header) => PopupMenuItem(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    header.text,
                    textAlign: header.textAlign,
                  ),
                  if (widget.sortColumn != null &&
                      widget.sortColumn == header.value)
                    widget.sortAscending!
                        ? const Icon(Icons.arrow_downward, size: 15)
                        : const Icon(Icons.arrow_upward, size: 15)
                ],
              ),
              value: header.value,
            ))
                .toList(),
            onSelected: (dynamic value) {
              if (widget.onSort != null) widget.onSort!(value);
            })
      ],
    );
  }

  List<Widget> mobileList() {
    final _decoration = BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)));
    final _rowDecoration = widget.rowDecoration ?? _decoration;
    final _selectedDecoration = widget.selectedDecoration ?? _decoration;
    return widget.source!.map((data) {
      return InkWell(
        onTap: () => widget.onTabRow?.call(data),
        child: Container(
          /// TODO:
          decoration: widget.selecteds!.contains(data)
              ? _selectedDecoration
              : _rowDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  if (widget.showSelect && widget.selecteds != null)
                    Checkbox(
                        value: widget.selecteds!.contains(data),
                        onChanged: (value) {
                          if (widget.onSelect != null) {
                            widget.onSelect!(value, data);
                          }
                        }),
                ],
              ),
              if (widget.commonMobileView && widget.dropContainer != null)
                widget.dropContainer!(data),
              if (!widget.commonMobileView)
                ...widget.headers
                    .where((header) => header.show == true)
                    .toList()
                    .map(
                      (header) => Container(
                    padding: const EdgeInsets.all(11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        header.headerBuilder != null
                            ? header.headerBuilder!(header.value)
                            : Text(
                          header.text,
                          overflow: TextOverflow.clip,
                          style: widget.selecteds!.contains(data)
                              ? widget.selectedTextStyle
                              : widget.rowTextStyle,
                        ),
                        const Spacer(),
                        // header.sourceBuilder != null
                        //     ? header.sourceBuilder!(
                        //     data[header.value], data)
                        //     : header.editable
                        //     ? TextEditableWidget(
                        //   data: data,
                        //   header: header,
                        //   textAlign: TextAlign.end,
                        //   onChanged: widget.onChangedRow,
                        //   onSubmitted: widget.onSubmittedRow,
                        //   hideUnderline: widget.hideUnderline,
                        // )
                        //     : Text(
                        //   "${data[header.value]}",
                        //   style: widget.selecteds!.contains(data)
                        //       ? widget.selectedTextStyle
                        //       : widget.rowTextStyle,
                        // )
                      ],
                    ),
                  ),
                )
                    .toList()
            ],
          ),
        ),
      );
    }).toList();
  }

  static Alignment headerAlignSwitch(TextAlign? textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  Widget desktopHeader() {

    final _headerDecoration = widget.headerDecoration ??
        BoxDecoration(
            color: Colors.red,
            border:
            Border(bottom: BorderSide(color: Colors.black, width: 1)));


    return Container(
      decoration: _headerDecoration,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showSelect && widget.selecteds != null)

            Checkbox(
                value: widget.selecteds!.length == widget.source!.length &&
                    widget.source != null &&
                    widget.source!.isNotEmpty,
                onChanged: (value) {
                  if (widget.onSelectAll != null) widget.onSelectAll!(value);
                }),

          ...widget.headers.where((header) => header.show == true).map((header) =>
              Expanded(
                flex: header.flex,

                child: InkWell(
                  onTap: () {
                    if (widget.onSort != null && header.sortable) {
                      widget.onSort!(header.value);
                    }
                  },
                  child: header.headerBuilder != null
                      ? header.headerBuilder!(header.value)

                      : Container(
                    padding: const EdgeInsets.all(11),
                    alignment: headerAlignSwitch(header.textAlign),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          header.text,
                          textAlign: header.textAlign,
                          style: widget.headerTextStyle,
                        ),
                        if (widget.sortColumn != null &&
                            widget.sortColumn == header.value)
                          widget.sortAscending!
                              ? const Icon(Icons.arrow_downward,
                              size: 15)
                              : const Icon(Icons.arrow_upward,
                              size: 15)
                      ],
                    ),
                  ),
                )),
            ).toList()
        ],
      ),
    );
  }

  List<Widget> desktopList() {
    final _decoration = BoxDecoration(
    border: Border(
        bottom: BorderSide(color: Colors.grey[300]!, width: 1)
    ));
    final _rowDecoration = widget.rowDecoration ?? _decoration;
    final _selectedDecoration = widget.selectedDecoration ?? _decoration;

    List<Widget> widgets = [];

    for (var index = 0; index < widget.source!.length; index++) {
      final data = widget.source![index];
      widgets.add(Column(
        children: [
          InkWell(
            onTap: () {
              widget.onTabRow?.call(data);
              setState(() {
                widget.expanded![index] = !widget.expanded![index];
              });
            },
            child: Container(
              padding: EdgeInsets.all(widget.showSelect ? 0 : 11),

              /// TODO:
              decoration: widget.selecteds!.contains(data)
                  ? _selectedDecoration
                  : _rowDecoration,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showSelect && widget.selecteds != null)
                    Row(
                      children: [
                        Checkbox(
                            value: widget.selecteds!.contains(data),
                            onChanged: (value) {
                              if (widget.onSelect != null) {
                                widget.onSelect!(value, data);
                              }
                            }),
                      ],
                    ),
                  ...widget.headers
                      .where((header) => header.show == true)
                      .map(
                        (header) => Expanded(
                      flex: header.flex,
                      child: header.sourceBuilder != null
                          ? header.sourceBuilder!(data[header.value], data)
                          : header.editable
                          ? TextEditableWidget(
                        data: data,
                        header: header,
                        textAlign: header.textAlign,
                        onChanged: widget.onChangedRow,
                        onSubmitted: widget.onSubmittedRow,
                        hideUnderline: widget.hideUnderline,
                      )
                          : Text(
                        "${data[header.value]}",
                        textAlign: header.textAlign,
                        style: widget.selecteds!.contains(data)
                            ? widget.selectedTextStyle
                            : widget.rowTextStyle,
                      ),
                    ),
                  )
                      .toList()
                ],
              ),
            ),
          ),
          if (widget.isExpandRows &&
              widget.expanded![index] &&
              widget.dropContainer != null)
            widget.dropContainer!(data)
        ],
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return widget.reponseScreenSizes.isNotEmpty &&
        widget.reponseScreenSizes.contains(context.screenSize)
        ?
    /// for small screen
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// title and actions
        if (widget.title != null || widget.actions != null)
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.grey[300]!))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.title != null) widget.title!,
                if (widget.actions != null) ...widget.actions!
              ],
            ),
          ),

        if (widget.autoHeight)
          Column(
            children: [
              if (widget.showSelect && widget.selecteds != null)
                mobileHeader(),
              if (widget.isLoading) const LinearProgressIndicator(),
              ...mobileList(),
            ],
          ),
        if (!widget.autoHeight)
          Expanded(
            child: ListView(
              /// itemCount: source.length,
              children: [
                if (widget.showSelect && widget.selecteds != null)
                  mobileHeader(),
                if (widget.isLoading) const LinearProgressIndicator(),

                /// mobileList
                ...mobileList(),
              ],
            ),
          ),

        /// footer
        if (widget.footers != null)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [...widget.footers!],
          )
      ],
    )
    /**
     * for large screen
     */
        : Column(
      children: [
        //title and actions
        if (widget.title != null || widget.actions != null)
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.grey[300]!))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.title != null) widget.title!,
                if (widget.actions != null) ...widget.actions!
              ],
            ),
          ),

        /// desktopHeader
        if (widget.headers.isNotEmpty) desktopHeader(),

        if (widget.isLoading) const LinearProgressIndicator(),

        if (widget.autoHeight) Column(children: desktopList()),

        if (!widget.autoHeight)
        // desktopList
          if (widget.source != null && widget.source!.isNotEmpty)
            Expanded(child: ListView(children: desktopList())),

        //footer
        if (widget.footers != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [...widget.footers!],
          )
      ],
    );
  }
}