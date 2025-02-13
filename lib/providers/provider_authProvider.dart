import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _currentUsername;

  String? get currentUsername => _currentUsername;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static final List<Map<String, String>> _users = [
    {'username': 'Caroline', 'password': 'carol1234'},
    {'username': 'Miguel', 'password': 'miguel1234'}
  ];

  static List<Map<String, String>> get users => _users;

  Future<bool> loginUser(String username, String password) async {
    print('Available users: $users');
    print(
        'Checking credentials for username: $username and password: $password');

    final validatedUser = users.any(
        (user) => user['username'] == username && user['password'] == password);

    print('Validation result: $validatedUser');

    if (validatedUser) {
      _currentUsername = username;

      // Salvar o username no SharedPreferences
      final prefs = await _prefs;
      await prefs.setString('username', username);
      notifyListeners();
      return true;
    }
    return false;
  }

  AuthProvider() {
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await _prefs;

    // Recupera o username salvo, se existir
    _currentUsername = prefs.getString('username');
    print('User loaded: $_currentUsername');
    notifyListeners();
  }

  void logout() async {
    _currentUsername = null;
    final prefs = await _prefs;

    // Remove o username do SharedPreferences
    await prefs.remove('username');

    notifyListeners();
  }
}
