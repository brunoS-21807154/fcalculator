import 'package:flutter/material.dart';
import 'package:fcalculator/screens/calculatorScreen.dart';

void main() => runApp(FCalculador());

class FCalculador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CalculatorScreen(title: 'FCalculador'));
  }
}



