import 'dart:async';

import 'package:fcalculator/data/datasource.dart';

class HistoryManager {

  static HistoryManager _instance;

  HistoryManager._internal();

  static HistoryManager getInstance() {
    if (_instance == null) {
      _instance = HistoryManager._internal();
    }
    return _instance;
  }

  List _content = [];

  DataSource dataSource = DataSource.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  void onGettingHistory() {

    _input.add(dataSource.getAll());

    print(_content);
  }

  void dispose() => _controller.close();
}
