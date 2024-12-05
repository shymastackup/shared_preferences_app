import 'package:flutter/material.dart';
import 'package:pro_shered_preference/pro_shered_preference.dart';


class UsernameNotifier extends ChangeNotifier {
  List<String> _usernames = [];

  List<String> get usernames => _usernames;

  UsernameNotifier() {
    _loadUsernames();
  }

  Future<void> _loadUsernames() async {
    final prefs = await SharedPreferences.getInstance();
    _usernames = prefs.getStringList('usernames') ?? [];
    notifyListeners();
  }

  Future<void> addUsername(String username) async {
    _usernames.add(username);
    await _saveUsernames();
    notifyListeners();
  }

  Future<void> editUsername(int index, String newUsername) async {
    _usernames[index] = newUsername;
    await _saveUsernames();
    notifyListeners();
  }

  Future<void> deleteUsername(int index) async {
    _usernames.removeAt(index);
    await _saveUsernames();
    notifyListeners();
  }

  Future<void> _saveUsernames() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('usernames', _usernames);
  }
}
