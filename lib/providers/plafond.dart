import 'package:flutter/foundation.dart';

class Plafond with ChangeNotifier{

  int _plafond = 0;

  int get value => _plafond;

  setPlafond(int value) {
    _plafond = value;
    notifyListeners();
  }

  void incrementPlafond(int value) {
   _plafond += value;
   notifyListeners();
  }

    void decrementPlafond(int value){
    _plafond-=value;
    notifyListeners();
  }
}