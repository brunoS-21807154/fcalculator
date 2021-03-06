import "dart:async";
import 'package:expressions/expressions.dart';
import 'package:fcalculator/data/datasource.dart';
import 'package:fcalculator/blocs/historyManager.dart';

class Calculator {
  String _content;
  final historyManager = HistoryManager();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  void onReceiveSymbol(symbol) {
    if (_content == "0" && symbol == "0") {
      onResetNumberDisplay();
    } else if (_content == "0") {
      _content = symbol;
      _input.add(_content);
    } else if ((symbol == '+' ||
            symbol == '-' ||
            symbol == '*' ||
            symbol == '/') &&
          (_content[_content.length - 1] == '+' ||
            _content[_content.length - 1] == '-' ||
            _content[_content.length - 1] == '*' ||
            _content[_content.length - 1] == '/')) {
      _content = _content.substring(0, _content.length - 1);
      _content += symbol;
      _input.add(_content);
    } else {
      _content = _content == null ? symbol : _content += symbol;
      _input.add(_content);
    }
  }

  void onResetNumberDisplay() {
    _content = "0";
    _input.add(_content);
  }

  void onDeleteLastSymbol() {
    if (_content.length > 1) {
      _content = _content.substring(0, _content.length - 1);
      _input.add(_content);
    }
  }

  void onEquals() {

    DataSource dataSource = DataSource.getInstance();

    String operation = _content;

    final expression = Expression.parse(_content);
    _content = ExpressionEvaluator().eval(expression, null).toString();



    if(_content.length > 1){
      if(_content[_content.length - 2] == '.' && _content[_content.length - 1] == '0'){
        _content = _content.substring(0, _content.length - 2);
        _input.add(_content);
      }
    }
    _input.add(_content);

    operation += "=$_content";

    print(operation);

    dataSource.insert(operation);

    historyManager.onGettingHistory();

  }

  void dispose() => _controller.close();
}
