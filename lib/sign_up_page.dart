import 'package:first_project_flutter/database/app_database.dart';
import 'package:first_project_flutter/providers/provider_authProvider.dart';
import 'package:first_project_flutter/utils/spaces.dart';
import 'package:first_project_flutter/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUpUser(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final username = userNameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        final existingUser = await authProvider.getUserByEmail(email);
        if (existingUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Este email já está em uso')),
          );
          return;
        }

        if (await authProvider.registerUser(username, email, password)) {
          final users = await AppDatabase.instance.getAllUsers();
          print('usuarios cadastrados: $users');

          Navigator.pushReplacementNamed(context, '/signin',
              arguments: authProvider);
          print('User registered sucessfully');
        } else {
          // Exibe um alerta para credenciais inválidas
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to register user')),
          );
        }
      } catch (e) {
        print('Sign up error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong, try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Sign Up!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5)),
                verticalSpacing(40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextField(
                        controller: userNameController,
                        hintText: "Name",
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 5) {
                            return "Your username must be at least 5 chacacters";
                          } else if (value != null && value.isEmpty) {
                            return "Please type your username";
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(24),
                      LoginTextField(
                        controller: emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please, type your email";
                          } else if (value != null && !value.contains("@")) {
                            return "Email invalid";
                          }
                          return null; //se conseguir passar por isso tudo, vai retornar nulo, validação feira corretamente.
                        },
                      ),
                      verticalSpacing(24),
                      LoginTextField(
                        hasAsterisks: true,
                        controller: passwordController,
                        hintText: 'Password',
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please, enter your password";
                          } else if (value != null && value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpacing(30),
                ElevatedButton(
                  onPressed: () {
                    signUpUser(context);
                  },
                  child: const Text(
                    'Creat Account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do you have account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        print('Clicked on login');
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
