import 'package:flutter/material.dart';

class ClickModel extends ChangeNotifier {
  bool _isActivate = false;

  void toggle() {
    _isActivate = !_isActivate;
    notifyListeners();
  }

  void reset() {
    _isActivate = false;
    notifyListeners();
  }

  bool isActive() {
    return _isActivate;
  }
}
