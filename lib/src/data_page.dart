import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';
import './responsive_datatable.dart';
import './datatable_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  int _currentPage = 1;
  List<Map<String, dynamic>> _sourceFiltered = [];
  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  bool _showSelect = true;
  List<Map<String, dynamic>> _selecteds = [];
  List <Map<String, dynamic>> _source = [];
  String? _searchKey = "id";
  bool _isSearch = false;
  // List<Map<String, dynamic>> data = [];
  List<DatatableHeader> _headers = [];


  // Future<void> fetchData() async {
  //   final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = jsonDecode(response.body);
  //     });
  //     print(data);
  //   }
  // }

  // Future<List<Map<String, dynamic>>> fetchData() async {
  //   final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = jsonDecode(response.body);
  //     final List<Map<String, dynamic>> source = jsonData.cast<Map<String, dynamic>>();
  //     print(source);
  //     return source;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/simcards'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Map<String, dynamic>> source = jsonData.cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> temps = [];

      for (var i = 0; i < source.length; i++) {
        var item = source[i];
        temps.add({
          "cliente": item['id'],
          "numerochip": "${item['id']}\000${item['id']}",
          "simcon": "simcon ${item['id']}",
          "fornecedor": "fornecedor-${item['id']}",
          "numerolinha": item['id'] * 10.00,
        });
      }
      print(temps);
      return temps;
    } else {
      return [];
    }
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var _expandedLen =
    _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(Duration(seconds: 0)).then((value) {
      _expanded = List.generate(_expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _headers = [
      DatatableHeader(
        text: "Cliente",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.center,
      ),
      DatatableHeader(
        text: "N° Chip(ICCID)",
        value: "numerochip",
        show: true,
        flex: 2,
        sortable: true,
        editable: true,
        textAlign: TextAlign.center,
      ),
      DatatableHeader(
        text: "Simcon",
        value: "simcon",
        show: true,
        sortable: true,
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
        show: true,
        sortable: true,
        textAlign: TextAlign.center,
      ),
    ];
    fetchData();
  }

  _initializeData() async {
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de SIMCARDS'),
        actions: [
          IconButton(
            onPressed: _initializeData,
            icon: Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                ///Aqui estou envolvendo minha tabela e linhas
                elevation: 3,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                  child:  ResponsiveDatatable(
                    title: TextButton.icon(
                      onPressed: () => {},
                      icon: Icon(Icons.add),
                      label: Text("Novo SIMCARD"),
                    ),
                    reponseScreenSizes: [ScreenSize.xs],
                    actions: [
                      if (_isSearch)
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Enter search term based on ' +
                                      _searchKey!
                                          .replaceAll(new RegExp('[\\W_]+'), ' ')
                                          .toUpperCase(),
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          _isSearch = false;
                                        });
                                        _initializeData();
                                      }),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
                              onSubmitted: (value) {
                                // _filterData(value);
                              },
                            )),
                      if (!_isSearch)
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _isSearch = true;
                              });
                            })
                    ],
                    headers: _headers,
                    source: _source,
                    selecteds: _selecteds,
                    showSelect: _showSelect,
                    autoHeight: false,
                    dropContainer: (data) {
                      if (int.tryParse(data['id'].toString())!.isEven) {
                        return Text("is Even");
                      }
                      return _DropDownContainer(data: data);
                    },

                    onChangedRow: (value, header) {
                      /// print(value);
                      /// print(header);
                    },
                    onSubmittedRow: (value, header) {
                      /// print(value);
                      /// print(header);
                    },
                    onTabRow: (data) {
                      print(data);
                    },

                    onSort: (value) {
                      setState(() => _isLoading = true);

                      setState(() {
                        _sortColumn = value;
                        _sortAscending = !_sortAscending;
                        if (_sortAscending) {
                          _sourceFiltered.sort((a, b) =>
                              b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                        } else {
                          _sourceFiltered.sort((a, b) =>
                              a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                        }
                        var _rangeTop = _currentPerPage! < _sourceFiltered.length
                            ? _currentPerPage!
                            : _sourceFiltered.length;
                        _source = _sourceFiltered.getRange(0, _rangeTop).toList();
                        _searchKey = value;

                        _isLoading = false;
                      });
                    },
                    expanded: _expanded,
                    sortAscending: _sortAscending,
                    sortColumn: _sortColumn,
                    isLoading: _isLoading,
                    onSelect: (value, item) {
                      print("$value  $item ");
                      if (value!) {
                        setState(() => _selecteds.add(item));
                      } else {
                        setState(
                                () => _selecteds.removeAt(_selecteds.indexOf(item)));
                      }
                    },

                    onSelectAll: (value) {
                      if (value!) {
                        setState(() => _selecteds =
                            _source.map((entry) => entry).toList().cast());
                      } else {
                        setState(() => _selecteds.clear());
                      }
                    },

                    footers: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rows per page:"),
                      ),
                      if (_perPages.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton<int>(
                            value: _currentPerPage,
                            items: _perPages
                                .map((e) => DropdownMenuItem<int>(
                              child: Text("$e"),
                              value: e,
                            ))
                                .toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                _currentPerPage = value;
                                _currentPage = 1;
                                _resetData();
                              });
                            },
                            isExpanded: false,
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child:
                        Text("$_currentPage - $_currentPerPage of $_total"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: _currentPage == 1
                            ? null
                            : () {
                          var _nextSet = _currentPage - _currentPerPage!;
                          setState(() {
                            _currentPage = _nextSet > 1 ? _nextSet : 1;
                            _resetData(start: _currentPage - 1);
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: _currentPage + _currentPerPage! - 1 > _total
                            ? null
                            : () {
                          var _nextSet = _currentPage + _currentPerPage!;

                          setState(() {
                            _currentPage = _nextSet < _total
                                ? _nextSet
                                : _total - _currentPerPage!;
                            _resetData(start: _nextSet - 1);
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      )
                    ],

                    headerDecoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1))),

                    selectedDecoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(color: Colors.green[300]!, width: 1)),
                      color: Color(0xFFFFB347),
                    ),
                    headerTextStyle: TextStyle(color: Colors.white),
                    rowTextStyle: TextStyle(color: Colors.green),
                    selectedTextStyle: TextStyle(color: Colors.white),
                  )
              )
            ),
          ]
        ),
      ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),
        /// ],
        children: _children,
      ),
    );
  }
}


// DataTable(
// columns: _headers
//     .where((header) => header.show)
//     .map((header) => DataColumn(label: Text(header.text)))
//     .toList(),
// rows: data
//     .map(
// (item) => DataRow(
// cells: _headers
//     .where((header) => header.show)
//     .map(
// (header) => DataCell(
// Text(item[header.value].toString()),
// ),
// )
//     .toList(),
// ),
// )
//     .toList(),
// ),
