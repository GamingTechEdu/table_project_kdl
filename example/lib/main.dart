import 'package:flutter/material.dart';
// import 'package:projeto_kdl_flutter/export_form.dart';
import 'package:projeto_kdl_flutter/export_table.dart';

// void main() {
//     WidgetsFlutterBinding.ensureInitialized();
//     runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//     @override
//     Widget build(BuildContext context) {
//         return MaterialApp(
//             title: 'Flutter Demo',
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//                 primarySwatch: Colors.blue,
//                 visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             initialRoute: '/',
//             routes: {
//                 '/': (_) => DataPage(),
//             },
//         );
//     }
// }
//
//
//

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DataTableExample()
));



// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           child: ListView(
//             children: [
//               SelectSimcon(),
//               CheckValue(),
//               SimucNumber(),
//               LatLong(),
//               SimucAplication(),
//               NumberLight(),
//               SensorDimmer(),
//               Contact(),
//               SectorSubSector(),
//               Etiqueta(),
//               Comments(),
//             ],
//           ),
//         ));
//   }
// }
