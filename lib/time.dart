import 'package:flutter/foundation.dart';

class Time with ChangeNotifier{

  String _time = "";

  String get value => _time;

  setTime(String value) {
    _time = value;
    notifyListeners();
  }

}