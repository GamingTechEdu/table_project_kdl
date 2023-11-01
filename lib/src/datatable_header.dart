import 'package:flutter/material.dart';

import 'model/table_data_model.dart';

class DatatableHeader{
  final String text;
  final String value;
  final bool sortable;
  final bool editable;
  final bool selectable;
  final TextStyle? color;
  bool show;
  final TextAlign textAlign;
  final int flex;
  final Widget Function(dynamic value)? headerBuilder;
  final Widget Function(dynamic value, Map<String, dynamic> row)? sourceBuilder;

  DatatableHeader({
    required this.text,
    required this.value,
    this.textAlign = TextAlign.center,
    this.sortable = false,
    this.show = true,
    this.color,
    this.editable = false,
    this.selectable = false,
    this.flex = 1,
    this.headerBuilder,
    this.sourceBuilder,
  });

  factory DatatableHeader.fromMap(Map<String, dynamic> map) => DatatableHeader(
    text: map['text'],
    value: map['value'],
    sortable: map['sortable'],
    color: map['color'],
    show: map['show'],
    textAlign: map['textAlign'],
    flex: map['flex'],
    headerBuilder: map['headerBuilder'],
    sourceBuilder: map['sourceBuilder'],
  );

  Map<String, dynamic> toMap() => {
    "text": this.text,
    "value": this.value,
    "sortable": this.sortable,
    "color": this.color,
    "show": this.show,
    "textAlign": this.textAlign,
    "flex": this.flex,
    "headerBuilder": this.headerBuilder,
    "sourceBuilder": this.sourceBuilder,
  };
}

