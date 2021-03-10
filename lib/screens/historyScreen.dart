import 'package:flutter/material.dart';
import 'package:fcalculator/blocs/historyManager.dart';
import 'package:fcalculator/screens/calculatorScreen.dart';


class HistoricScreen extends StatelessWidget {

  HistoryManager historyManager = HistoryManager.getInstance();
  List samples = ["2+3=5", "6+6*12"];


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
            initialData: samples,
            stream: historyManager.output,
            builder: (BuildContext context, snapshot) => ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index)  {
                return ListTile(
                  leading: Image.asset('lib/assets/logo.jpg'),
                  title: Text(snapshot.data[index]),
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.dehaze),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalculatorScreen(title: 'FCalculador')),
            );
          },
        ),
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
