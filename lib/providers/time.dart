import 'package:flutter/foundation.dart';

class Time with ChangeNotifier{

  String _time = "0:0:0";

  String get value => _time;

  setTime(String value) {
    _time = value;
    notifyListeners();
  }

}