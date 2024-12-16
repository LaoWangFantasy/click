import 'package:flutter/material.dart';
import 'package:click/common/_theme.dart';

class GlobalModel extends ChangeNotifier {
  final _theme = const AppTheme();
  bool _isActivate = false;
  int _selectedIndex = 0;

  AppTheme get theme => _theme;
  int get selectedIndex => _selectedIndex;

  void toggleActivate() {
    _isActivate = !_isActivate;
    notifyListeners();
  }

  void resetActivate() {
    _isActivate = false;
    notifyListeners();
  }

  bool isActivate() {
    return _isActivate;
  }
  void setIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
  bool isSelected(int index) {
    return _selectedIndex == index;
  }
}