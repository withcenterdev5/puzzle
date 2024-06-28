import 'package:flutter/material.dart';

class Appstate extends ChangeNotifier {
  Appstate();

  bool _isActive = false;
  int _time = 0;
  int _move = 0;

  bool get isActive => _isActive;
  int get time => _time;
  int get move => _move;

  setMove({int? value}) {
    if (value != null) {
      _move = value;
    } else {
      _move += 1;
    }
    notifyListeners();
  }

  setIsActive({required bool value}) {
    _isActive = value;
    notifyListeners();
  }

  setTime([int? seconds]) {
    if (seconds != null) {
      _time = seconds;
    } else {
      _time += 1;
    }
    notifyListeners();
  }
}
