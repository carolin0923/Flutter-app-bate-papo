import 'package:first_project_flutter/providers/provider_authProvider.dart';
import 'package:first_project_flutter/utils/spaces.dart';
import 'package:first_project_flutter/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formkey = GlobalKey<
      FormState>(); //criando uma intancia, que está criando uma refrencia global que vai ser usada pra acessar o estado do formulario
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  //TODO: Validate email and username values
  void loginUser(BuildContext context) async {
    if (formkey.currentState != null && formkey.currentState!.validate()) {
      final username = userNameController.text;
      final password = passwordController.text;

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        if (await authProvider.loginUser(username, password)) {
          Navigator.pushReplacementNamed(context, '/chat',
              arguments: authProvider);
          print('Login successful for $username!');
        } else {
          // Exibe um alerta para credenciais inválidas
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid username or password')),
          );
        }
      } catch (e) {
        print('Login error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong, try again later.')),
        );
      }
    }
  }

  final _mainUrl =
      "https://medium.com/flutter-portugal/flutter-push-pop-push-8cc3b038f415";

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
              Text('Let\'s sign you in!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5)),

              //TODO: Align text to centre
              Text(
                'Welcome back! \n You\'ve been missed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              Image.asset('assets/illustration.png', height: 150),

              Form(
                key: formkey,
                child: Column(
                  children: [
                    LoginTextField(
                      hintText: "Enter your username",
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Your username should be more than 5 chacacters";
                        } else if (value != null && value.isEmpty) {
                          return "Please type your username";
                        }
                        return null;
                      },
                      controller: userNameController,
                    ),
                    verticalSpacing(24),
                    LoginTextField(
                      hasAsterisks: true,
                      controller: passwordController,
                      hintText: 'Enter your password',
                    ),
                  ],
                ),
              ),

              verticalSpacing(24),

              ElevatedButton(
                onPressed: () {
                  loginUser(context);
                },
                child: Text('Login',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
              ),

              GestureDetector(
                onTap: () async {
                  print('Link clicked!');
                  // ignore: deprecated_member_use
                  if (!await launch(_mainUrl)) {
                    throw 'Could not launch this';
                  }
                },
                child: Column(
                  children: [
                    Text('Find us on'),
                    Text(_mainUrl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
