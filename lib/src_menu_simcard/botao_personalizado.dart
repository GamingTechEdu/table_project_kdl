import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyButton(),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isLoading = false;
  bool _isChecked = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        _isChecked = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isChecked = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            fixedSize: Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0), // Ajuste o valor conforme necessário
            ),
          ),
          onPressed: _isLoading ? null : _isChecked ? null : _startLoading,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: _isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : _isChecked
                ? Icon(
              Icons.check,
              color: Colors.green,
            )
                : Text(
              'Confirmar',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        );
  }
}
