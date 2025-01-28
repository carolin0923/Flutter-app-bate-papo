import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _currentUsername;

  String? get currentUsername => _currentUsername;

  static final List<Map<String, String>> _users = [
    {'username': 'Caroline', 'password': 'carol1234'},
    {'username': 'Miguel', 'password': 'Miguel1234'}
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
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUsername = null;
    notifyListeners();
  }
}
