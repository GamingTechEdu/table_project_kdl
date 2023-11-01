import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository.dart';
import '../model/table_data_model.dart';

// class TableController {
//   final TableRepository _tableController;
//   TableController(this._tableController);
//
//   List<Map<String, dynamic>> listSims = ([]);
//
//   fetch() async {
//     listSims = await _tableController.getList();
//     print('Lista de Sims => $listSims');
//   }
// }

class TableController extends ChangeNotifier {
  final TableRepository _tableController;
  TableController(this._tableController);

  bool showSelect = true;
  bool sortAscending = true;
  String? sortColumn;
  String? searchKey = "numerochip";
  List<bool>? expanded;
  int _total = 100;
  int? currentPerPage = 25;
  int currentPage = 1;
  bool isLoading = true;
  List<Map<String, dynamic>> selecteds = [];
  List<Map<String, dynamic>> listSims = ([]);
  List<Map<String, dynamic>> sourceOriginal = ([]);
  List<Map<String, dynamic>> _sourceFiltered = ([]);

  int get total => _total;

  fetch() async {
    try {
      listSims = await _tableController.getList();
      sourceOriginal = listSims;
      _sourceFiltered = List.from(listSims);
      _total = _sourceFiltered.length;
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
      listSims.clear();
      sourceOriginal = listSims;
      listSims = _sourceFiltered.getRange(start, start + _expandedLen).toList();
      isLoading = false;
      notifyListeners();
    });
  }

  filterData(value) {
    isLoading = true;
    sourceOriginal = listSims;
    try {
      if (value == "" || value == null) {
        _sourceFiltered = sourceOriginal;
      } else {
        _sourceFiltered = sourceOriginal
            .where((data) => data[searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }
      _total = _sourceFiltered.length;
      var _rangeTop = _total < currentPerPage! ? _total : currentPerPage!;
      expanded = List.generate(_rangeTop, (index) => false);
      listSims = _sourceFiltered.getRange(0, _rangeTop).toList();
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
      _sourceFiltered
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      _sourceFiltered
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }

    var rangeTop = currentPerPage! < _sourceFiltered.length
        ? currentPerPage!
        : _sourceFiltered.length;
    listSims = _sourceFiltered.getRange(0, rangeTop).toList();
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
}
