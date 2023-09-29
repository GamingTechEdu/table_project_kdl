import 'package:flutter/material.dart';
import 'package:component_menu/package.dart';
import 'package:component_menu/src/api/api_client.dart';

void main() {
  runApp(Example());
}

class Example extends StatelessWidget {
  Example({super.key});

  final themeB = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.orangeAccent,
      secondary: Colors.orange,
      onSecondary: Colors.orangeAccent,
      error: Colors.red,
      onError: Colors.redAccent,
      background: Colors.yellow,
      onBackground: Colors.yellowAccent,
      surface: Colors.green,
      onSurface: Colors.black,
    ),
    primarySwatch: Colors.orange,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black26, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 4,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
      //bodyMedium:  TextStyle(color: Colors.yellow, fontSize: 18),
      //bodySmall:  TextStyle(color: Colors.yellow, fontSize: 16)
    ),
    useMaterial3: false,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return ScrollConfiguration(
          behavior: WidgetScrollBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: themeB,
      home: const MyExample(),
    );
  }
}

class MyExample extends StatefulWidget {
  const MyExample({super.key});

  @override
  State<MyExample> createState() => _MyExampleState();
}

class _MyExampleState extends State<MyExample> {
  final KdlController kdlController = KdlController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SimcardsManager(
          controller: kdlController,
          onOutput: (value) {
            print("VALUE--->>>");
            print(value);
          },
        ),
      ),
    );
  }
}