import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';
import 'datatable_header.dart';

/// `TextEditableWidget`
///
/// use to display when user allow any header columns to be editable
class TextEditableWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  /// `header`
  ///
  /// current editable text header
  final DatatableHeader header;

  /// `textAlign`
  ///
  /// by default textAlign will be center
  final TextAlign textAlign;

  /// `hideUnderline`
  ///
  /// allow use to decorate hideUnderline false or true
  final bool hideUnderline;

  /// `onChanged`
  ///
  /// trigger the call back update when user make any text change
  final Function(Map<String, dynamic> vaue, DatatableHeader header)? onChanged;

  /// `onSubmitted`
  ///
  /// trigger the call back when user press done or enter
  final Function(Map<String, dynamic> vaue, DatatableHeader header)?
      onSubmitted;

  const TextEditableWidget({
    Key? key,
    required this.data,
    required this.header,
    this.textAlign = TextAlign.center,
    this.hideUnderline = false,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: hideUnderline
              ? InputBorder.none
              : const UnderlineInputBorder(borderSide: BorderSide(width: 1)),
          alignLabelWithHint: true,
        ),
        textAlign: textAlign,
        controller: TextEditingController.fromValue(
          TextEditingValue(text: "${data[header.value]}"),
        ),
        onChanged: (newValue) {
          data[header.value] = newValue;
          onChanged?.call(data, header);
        },
        onSubmitted: (x) => onSubmitted?.call(data, header),
      ),
    );
  }
}
