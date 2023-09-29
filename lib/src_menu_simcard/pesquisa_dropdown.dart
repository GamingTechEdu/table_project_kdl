import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barra de Pesquisa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> dataList = [
    "Maçã",
    "Banana",
    "Laranja",
    "Pera",
    "Uva",
    "Manga",
    "Abacaxi",
    "Melancia",
    "Melão",
  ];

  List<String> filteredList = [];
  String selected = "";
  TextEditingController searchController = TextEditingController();

  void filterData(String query) {
    query = query.toLowerCase();
    filteredList = dataList.where((item) => item.toLowerCase().contains(query)).toList();
    if (query.isEmpty) {
      filteredList.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barra de Pesquisa'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filterData(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredList[index]),
                  onTap: () {
                    setState(() {
                      selected = filteredList[index];
                      searchController.text = selected;
                      filteredList.clear();
                    });
                  },
                  selected: selected == filteredList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
