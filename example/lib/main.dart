// import 'package:projeto_kdl_flutter/export.dart';
// import 'package:flutter/material.dart';
//
// void main() => runApp(
//     MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: DataTableExample()
//     )
// );

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto_kdl_flutter/responsive_table.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            routes: {
                '/': (_) => DataPage(),
            },
        );
    }
}



