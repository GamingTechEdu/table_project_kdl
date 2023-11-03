import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/src/controller/table_controller.dart';
import 'package:projeto_kdl_flutter/src/repositories/table_repository_mock.dart';
import 'package:provider/provider.dart';
import '../datatable_views.dart';
import 'package:adaptivex/adaptivex.dart';
import '../data/data_initialization.dart';
import '../data/api_service.dart';
import '../controller/controller.dart';
import 'package:get/get.dart';

import '../utils/api_utils.dart';

class InteractiveDataTableView extends StatefulWidget {
  const InteractiveDataTableView({super.key});

  @override
  State<InteractiveDataTableView> createState() =>
      _InteractiveDataTableViewState();
}

class _InteractiveDataTableViewState extends State<InteractiveDataTableView> {
  final searchController = Get.put(Controller());

  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    final tableController = context.read<TableController>();
    tableController.fetch();
  }

  // Future<void> fetchData() async {
  //   try {
  //     _controller.fetch();
  //     List<Map<String, dynamic>> source = await _controller.listSims;
  //       _source = source;
  //     print("Source => $_source");
  //     setState(() {
  //       _sourceOriginal = source;
  //       _sourceFiltered = List.from(_source);
  //       _total = _sourceFiltered.length;
  //       _resetData();
  //     });
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }
  //
  // _resetData({start = 0}) async {
  //   setState(() => _isLoading = true);
  //   var _expandedLen =
  //   _total - start < _controller.currentPerPage! ? _total - start : _controller.currentPerPage;
  //   Future.delayed(Duration(seconds: 0)).then((value) {
  //     _expanded = List.generate(_expandedLen as int, (index) => false);
  //     _source.clear();
  //     _sourceOriginal = _source;
  //     _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
  //     setState(() => _isLoading = false);
  //   });
  // }
  //
  // _filterData(value) {
  //   setState(() => _isLoading = true);
  //   _sourceOriginal = _source;
  //   print(_sourceOriginal);
  //   try {
  //     if (value == "" || value == null) {
  //       _sourceFiltered = _sourceOriginal;
  //     } else {
  //       _sourceFiltered = _sourceOriginal
  //           .where((data) => data[_searchKey!]
  //           .toString()
  //           .toLowerCase()
  //           .contains(value.toString().toLowerCase()))
  //           .toList();
  //     }
  //     _total = _sourceFiltered.length;
  //     var _rangeTop = _total < _controller.currentPerPage! ? _total : _controller.currentPerPage!;
  //     _expanded = List.generate(_rangeTop, (index) => false);
  //     _source = _sourceFiltered.getRange(0, _rangeTop).toList();
  //
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() => _isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    final tableController = Provider.of<TableController>(context);

    return Scaffold(
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
                elevation: 3,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  reponseScreenSizes: [ScreenSize.xs],
                  actions: [
                    TextButton.icon(
                      onPressed: () => {setState(() {})},
                      icon: Icon(Icons.add),
                      label: Text("Novo SIMCARD"),
                    ),
                    TextButton.icon(
                      onPressed: () => {print('Editar')},
                      icon: Icon(Icons.edit),
                      label: Text("Editar"),
                    ),
                    TextButton.icon(
                      onPressed: () => {print('Exportar')},
                      icon: Icon(Icons.add_chart),
                      label: Text("Exportar"),
                    ),
                    TextButton.icon(
                      onPressed: () => {tableController.fetch()},
                      icon: Icon(Icons.refresh_sharp),
                      label: Text("Refresh"),
                    ),
                    TextButton.icon(
                      onPressed: () => {print('Delete')},
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
                    Obx(() {
                      if (searchController.isSearch.value) {
                        return Container(
                          width: 300,
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Pesquise por ' +
                                  tableController.searchKey!
                                      .replaceAll(new RegExp('[\\W_]+'), ' ')
                                      .toUpperCase(),
                              prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  searchController.setSearchState(false);
                                  tableController.fetch();
                                  print("Passei aqui");
                                },
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                tableController.fetch();
                              }
                            },
                            onSubmitted: (value) {
                              tableController.filterData(value);
                              print(value);
                            },
                          ),
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            searchController.setSearchState(true);
                          },
                        );
                      }
                    })
                  ],
                  headers: headers,
                  source: tableController.listSims,
                  selecteds: tableController.selecteds,
                  showSelect: tableController.showSelect,
                  autoHeight: false,
                  dropContainer: (data) {
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
                  onSort: (value) => tableController.onSort(value),
                  expanded: tableController.expanded,
                  sortAscending: tableController.sortAscending,
                  sortColumn: tableController.sortColumn,
                  isLoading: tableController.isLoading,
                  onSelect: (value, item) =>
                      tableController.onSelect(value, item),
                  onSelectAll: (value) => tableController.onSelectAll(value),
                  footers: [
                    Container(
                      padding: UTILS.padding_horizontal_15,
                      child: const Text("Linhas por página: "),
                    ),
                    if (tableController.perPages.isNotEmpty)
                      Container(
                        padding: UTILS.padding_horizontal_15,
                        child: DropdownButton<int>(
                          value: tableController.currentPerPage,
                          items: tableController.perPages
                              .map((e) => DropdownMenuItem<int>(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              tableController.currentPerPage = value;
                              tableController.currentPage;
                              tableController.resetData();
                            });
                          },
                          isExpanded: false,
                        ),
                      ),
                    Container(
                      padding: UTILS.padding_horizontal_15,
                      child: Text(
                          "${tableController.currentPage} - ${tableController.currentPerPage} de ${tableController.total}"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      onPressed: () {
                        tableController.backArrow(tableController);
                      },
                      padding: UTILS.padding_horizontal_15,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        tableController.nextPage(tableController);
                      },
                      padding: UTILS.padding_horizontal_15,
                    )
                  ],
                  headerDecoration: const BoxDecoration(
                      color: Color(0xffD3D3D3),
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2))),
                  selectedDecoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 1)),
                    color: Color(0xFFD3D3D3),
                  ),
                  headerTextStyle: const TextStyle(color: Colors.black),
                  rowTextStyle: const TextStyle(color: Colors.orange),
                  selectedTextStyle: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ]),
      // ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;

  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableController = Provider.of<TableController>(context);

    List<Widget> _children = [];

    data.forEach((key, value) {
      if (key != 'cliente' &&
          key != 'id' &&
          key != 'simcon' &&
          key != 'numerochip' &&
          key != 'fornecedor' &&
          key != 'numerolinha') {
        _children.add(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text('${tableController.verification(key)}:'),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      }
    });

    return Container(
      child: Column(
        children: _children,
      ),
    );
  }
}
