import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _autoModeEnabled = false;
  ThemeMode get themeMode => _themeMode;
  bool get autoModeEnabled => _autoModeEnabled;

  void toggleTheme() {
    _autoModeEnabled = false;
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void enableAutoMode() {
    _autoModeEnabled = true;
    _updateBasedOnTime();
  }

  void disableAutoMode() {
    _autoModeEnabled = false;
    notifyListeners();
  }

  void _updateBasedOnTime() {
    final hour = DateTime.now().hour;
    _themeMode = (hour >= 7 && hour < 19) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void checkAutoUpdate() {
    if (_autoModeEnabled) _updateBasedOnTime();
  }
}
