import 'dart:async';

import 'package:fcalculator/data/datasource.dart';

class HistoryManager {


  List _content = [];

  DataSource dataSource = DataSource.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  void onGettingHistory() {
    _content = dataSource.getAll();

    _input.add(_content);

    print(_content);

  }

  void dispose() => _controller.close();
}
