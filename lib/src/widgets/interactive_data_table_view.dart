import 'package:flutter/material.dart';
import '../datatable_views.dart';
import 'package:adaptivex/adaptivex.dart';
import '../data/data_initialization.dart';
// import '../data/api_service.dart';
import '../data/teste_notifier.dart';


class InteractiveDataTableView extends StatefulWidget {
  const InteractiveDataTableView({super.key});

  @override
  State<InteractiveDataTableView> createState() => _InteractiveDataTableViewState();
}

class _InteractiveDataTableViewState extends State<InteractiveDataTableView> {
  int _currentPage = 1;
  List<Map<String, dynamic>> _sourceFiltered = [];
  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  List<int> _perPages = [15, 25, 55, 105, 155, 205];
  int _total = 100;
  int? _currentPerPage = 25;
  List<bool>? _expanded;
  bool _showSelect = true;
  List<Map<String, dynamic>> _selecteds = [];
  List <Map<String, dynamic>> _source = [];
  String? _searchKey = "ICCID";
  bool _isSearch = false;
  List<Map<String, dynamic>> _sourceOriginal = [];
  final apiNotifier = ApiNotifier();

  // Future<void> fetchData() async {
  //   try {
  //     List<Map<String, dynamic>> source = await ApiService.fetchData();
  //     setState(() {
  //       _source = source;
  //       print(_source);
  //       _sourceFiltered = List.from(_source);
  //       _total = _sourceFiltered.length;
  //       _resetData();
  //     });
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }

  void initState() {
    super.initState();
    apiNotifier.addListener(() {
      setState(() {
        apiNotifier.fetchData();
      });
    });
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

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) => data[_searchKey!]
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(_rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Controle de SIMCARDS'),
      //   actions: [
      //     IconButton(
      //       onPressed: fetchData,
      //       icon: Icon(Icons.refresh_sharp),
      //     ),
      //   ],
      // ),
      // body: SingleChildScrollView(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(0),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.95,
                ),

                child: Card(
                  ///Aqui estou envolvendo minha tabela e linhas
                    elevation: 3,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child:  ResponsiveDatatable(
                      title: TextButton.icon(
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: Text("Novo SIMCARD"),
                          //       content: ComponentForm(),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(context); // Fechar o AlertDialog
                          //           },
                          //           child: Text("Fechar"),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                          print('Novo Simcard');
                        },
                        icon: Icon(Icons.add),
                        label: Text("Novo SIMCARD"),
                      ),
                      reponseScreenSizes: [ScreenSize.xs],
                      actions: [
                        TextButton.icon(
                          onPressed: () => {
                            print('Editar')
                          },
                          icon: Icon(Icons.edit),
                          label: Text("Editar"),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            print('Exportar')
                          },
                          icon: Icon(Icons.add_chart),
                          label: Text("Exportar"),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            print('Atualizar Tabela'),
                          },
                          icon: Icon(Icons.refresh_sharp),
                          label: Text("Refresh"),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            print('Delete')
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Deletar",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                        if (_isSearch)
                          Container(
                            width: 300,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Pesquise por ' +
                                      _searchKey!
                                          .replaceAll(new RegExp('[\\W_]+'), ' ')
                                          .toUpperCase(),
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          _isSearch = false;
                                        });
                                        initializeData();
                                      }),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
                              onSubmitted: (value) {
                                _filterData(value);
                              },
                            ),
                          ),
                        if (!_isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  _isSearch = true;
                                });
                              })
                      ],

                      headers: headers,
                      source: _source,
                      selecteds: _selecteds,
                      showSelect: _showSelect,
                      autoHeight: false,
                      dropContainer: (data) {
                        // if (int.tryParse(data['id'].toString())!.isEven) {
                        //   return Text("is Even");
                        // }
                        return _DropDownContainer(data: data);
                      },
                      onChangedRow: (value, header) {
                        // print(value);
                        // print(header);
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
                          setState(() => _selecteds.removeAt(_selecteds.indexOf(item)));
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

                        if (_perPages!.isNotEmpty)

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
                          color: Color(0xffD3D3D3),
                          border: Border(
                              bottom: BorderSide(color: Colors.black, width: 2))),
                      selectedDecoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: Colors.blue, width: 1)),
                        color: Color(0xFFD3D3D3),
                      ),
                      headerTextStyle: TextStyle(color: Colors.black),
                       rowTextStyle: TextStyle(color: Colors.orange),
                      selectedTextStyle: TextStyle(color: Colors.blue),
                    )
                )
            ),
          ]
      ),
      // ),
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
          // Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(entry.value.toString()),
          ),
        ],
      );

      return w;
    }).toList();

    return Container(
      child: Column(
        children: _children,
      ),
    );
  }
}
