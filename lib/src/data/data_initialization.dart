import '../datatable_header.dart';
import 'package:flutter/material.dart';

List<DatatableHeader> headers = [
  DatatableHeader(
    text: "Cliente",
    value: "cliente",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "N° Chip(ICCID)",
    value: "numerochip",
    show: true,
    flex: 2,
    color: const TextStyle(color: Colors.orange),
    sortable: true,
    editable: false,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "SIMCON",
    value: "simcon",
    show: true,
    sortable: true,
    color: const TextStyle(color: Colors.orange),
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "Fornecedor",
    value: "fornecedor",
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
  DatatableHeader(
    text: "N° da linha(MSISDN)",
    value: "numerolinha",
    color: const TextStyle(color: Colors.orange),
    show: true,
    sortable: true,
    textAlign: TextAlign.center,
  ),
];

