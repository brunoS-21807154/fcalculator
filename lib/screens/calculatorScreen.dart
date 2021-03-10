import 'package:flutter/material.dart';
import 'package:fcalculator/widgets/keyboard.dart';
import 'package:fcalculator/widgets/display.dart';
import 'package:fcalculator/screens/historyScreen.dart';
import 'package:fcalculator/blocs/calculator.dart';

class CalculatorScreen extends StatefulWidget {
  final String title;

  CalculatorScreen({this.title});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final calculator = Calculator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            initialData: "0",
            stream: calculator.output,
            builder: (BuildContext context, snapshot) => Display(
              content: snapshot.data,
            ),
          ),
          Keyboard(
            calculator: calculator,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.dehaze),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoricScreen()),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    calculator.dispose();
    super.dispose();
  }
}