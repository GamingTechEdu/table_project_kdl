import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository.dart';

class TableController extends ChangeNotifier {
  final TableRepository _tableController;
  TableController(this._tableController);


  List<int> perPages = [15, 25, 55, 105, 155, 205];
  bool showSelect = true;
  bool sortAscending = true;
  String? sortColumn ;
  String? searchKey = "numerochip";
  List<bool>? expanded;
  int _total = 100;
  int? currentPerPage = 25;
  int currentPage = 1;
  bool isLoading = true;
  bool isSearch = false;
  List<Map<String, dynamic>> selecteds = [];
  List<Map<String, dynamic>> listSims = ([]);
  List<Map<String, dynamic>> sourceOriginal = ([]);
  List<Map<String, dynamic>> sourceFiltered = ([]);

  int get total => _total;

  fetch() async {
    try {
      listSims = await _tableController.getList();
      sourceOriginal = listSims;
      sourceFiltered = List.from(listSims);
      _total = sourceFiltered.length;
      resetData();
      notifyListeners();
    } catch (e) {
      print('Error $e');
    }
  }

  resetData({start = 0}) async {
    isLoading = true;
    var _expandedLen =
        _total - start < currentPerPage! ? _total - start : currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      expanded = List.generate(_expandedLen as int, (index) => false);
      sourceOriginal = listSims;
      listSims.clear();
      listSims = sourceFiltered.getRange(start, start + _expandedLen).toList();
      print(sourceFiltered.length);
      isLoading = false;
      notifyListeners();
    });
  }

  filterData(value) async{
    isLoading = true;
    sourceOriginal = await _tableController.getList();
    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) => data[searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }
      _total = sourceFiltered.length;
      var _rangeTop = _total < currentPerPage! ? _total : currentPerPage!;
      expanded = List.generate(_rangeTop, (index) => false);
      listSims = sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  onSort(String value) {
    isLoading = true;

    sortColumn = value;
    sortAscending = !sortAscending;

    if (sortAscending) {
      sourceFiltered
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      sourceFiltered
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }

    var rangeTop = currentPerPage! < sourceFiltered.length
        ? currentPerPage!
        : sourceFiltered.length;
    listSims = sourceFiltered.getRange(0, rangeTop).toList();
    searchKey = value;
    isLoading = false;
    notifyListeners();
  }

  void onSelect(bool? value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value!) {
      selecteds.add(item);
      notifyListeners();
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
      notifyListeners();
    }
  }

  void onSelectAll(bool? value) {
    if (value!) {
      selecteds = listSims.map((entry) => entry).toList().cast();
      notifyListeners();
    } else {
      selecteds.clear();
      notifyListeners();
    }
  }

  void backArrow(TableController dataController) {
    if (currentPage == 1) {
      return;
    } else {
      var _nextSet = currentPage - currentPerPage!;
      currentPage = _nextSet > 1 ? _nextSet : 1;
      dataController.resetData(start: currentPage - 1);
      notifyListeners();
    }
  }

  void nextPage(TableController dataController) {
    if (currentPage + currentPerPage! - 1 <= _total) {
      var _nextSet = currentPage + currentPerPage!;
      currentPage = _nextSet < total ? _nextSet : total - currentPerPage!;
      dataController.resetData(start: _nextSet - 1);
      notifyListeners();
    } else {
      return;
    }
  }

  String verification(String value){
    switch(value) {
      case 'numerochip':
        return 'ICCID';
      case 'simcon':
        return 'SIMCON';
      case 'fornecedor':
        return 'Fornecedor';
      case 'slotsimcon':
        return 'Slot SIMCON';
      case 'datainstalacao':
        return 'Data de Instalação';
      case 'dataaticacao':
        return 'Data de Ativação';
      case 'operadora':
        return 'Operadora';
      case 'plano':
        return 'Plano';
      case 'apn':
        return 'Apn';
      case 'numeroip':
        return 'Número de IP';
      case 'obs':
        return 'Observação';

    }
    return value;
  }

  LengthLimitingTextInputFormatter searchLimit(){
    return LengthLimitingTextInputFormatter(
      (searchKey == 'simcon') ? 7 :
      (searchKey == 'numerochip') ? 20 :
      (searchKey == 'numerolinha') ? 15 :
      (searchKey == 'cliente') ? 15 :
      (searchKey == 'fornecedor') ? 15 : null,
    );  //
  }

}
