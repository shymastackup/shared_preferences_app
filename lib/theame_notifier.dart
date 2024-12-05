import 'package:flutter/material.dart';
import 'package:pro_shered_preference/pro_shered_preference.dart';


class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool _notificationsEnabled = false;

  bool get isDarkTheme => _isDarkTheme;
  bool get notificationsEnabled => _notificationsEnabled;

  ThemeNotifier() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
    notifyListeners();
  }

  Future<void> updateTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }

  Future<void> updateNotifications(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', isEnabled);
    _notificationsEnabled = isEnabled;
    notifyListeners();
  }
}
