import 'package:flutter/material.dart';
import 'package:fcalculator/blocs/calculator.dart';
import 'package:fcalculator/blocs/display.dart';
import 'package:fcalculator/blocs/keyboard.dart';
import 'package:fcalculator/blocs/historyManager.dart';

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

class HistoricScreen extends StatelessWidget {

  final historyManager = HistoryManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Histórico"),
        ),
        body: StreamBuilder(
            stream: historyManager.output,
            builder: (BuildContext context, snapshot) => ListView.builder(
                  itemCount: snapshot.data,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset('lib/assets/logo.jpg'),
                      title: Text(snapshot.data.toString()),
                    );
                  },
                )),
      ),
    );
  }

  @override
  void dispose() {
    historyManager.dispose();
  }
}

/*ListView.builder(
          itemCount: samples.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset('lib/assets/logo.jpg'),
              title: Text(samples[index]),
            );
          },
        ),*/
