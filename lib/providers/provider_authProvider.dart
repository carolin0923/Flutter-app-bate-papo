import 'package:first_project_flutter/database/app_database.dart';
import 'package:first_project_flutter/models/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _currentUserEmail;

  String? get currentUserEmail => _currentUserEmail;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //instanciar o banco de dados
  final AppDatabase _database = AppDatabase.instance;

  //metodo pra fazer login
  Future<bool> loginUser(String email, String password) async {
    try {
      //buscar o usuario no banco de dados
      final user = await _database.getUserByEmail(email);

      //verificar se o usuario existe e se a senha está correta
      if (user != null && user.password == password) {
        _currentUserEmail = user.email;

        //salvar o usuario(username) no sahred preferences
        final prefs = await _prefs;
        await prefs.setString('email', user.email);
        //notifica a UI
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error when doing login: $e');
      return false;
    }
  }

  //cadastrar um novo usuario

  Future<bool> registerUser(
      String username, String email, String password) async {
    try {
      //o usuario existe?
      final existsUser = await _database.getUserByEmail(email);

      if (existsUser != null) {
        print('user is already registered!');
        return false;
      }

      final newUser = UserRegistration(
          username: username, email: email, password: password);
      await _database.insertUser(newUser);
      print('User registered successfully: $email');
      return true;
    } catch (e) {
      print('Error when register user: $e');
      return false;
    }
  }

  //metodo pra atualizar o usuario
  Future<UserRegistration?> updateUser(UserRegistration user) async {
    try {
      return await _database.updateUser(user);
    } catch (e) {
      print('Error when update user: $e');
      return null;
    }
  }

  void logout() async {
    _currentUserEmail = null;

    //limpar o nome do usuario que ja foi salvo no shared preferencs
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await _prefs;

    // Recupera o username salvo, se existir
    _currentUserEmail = prefs.getString('username');
    print('User loaded: $_currentUserEmail');
    notifyListeners();
  }

  Future<UserRegistration?> getUserByEmail(String email) async {
    try {
      return await _database.getUserByEmail(email);
    } catch (e) {
      print('Error ao encontrar o usuario por email: $e');
      return null;
    }
  }
}
  

  //metodo pra deletar um usuario

