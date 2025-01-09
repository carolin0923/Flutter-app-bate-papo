import 'package:first_project_flutter/chat_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formkey = GlobalKey<FormState>();

  //TODO: Validate email and username values
  void loginUser(context) {
    if (formkey.currentState != null && formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatPage(username: userNameController.text)));
      print('login successful!');
    } else {
      print('not successful');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

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
              Image.network(
                  'https://revistacarro.com.br/wp-content/uploads/2018/05/mini_cooper_s_cabrio.jpg',
                  height: 150),

              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
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
                      decoration: InputDecoration(
                          hintText: 'Add your username',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Type your password',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 24,
              ),

              ElevatedButton(
                onPressed: () {
                  loginUser(context);
                },
                child: Text('Login',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
              ),

              GestureDetector(
                onTap: () {
                  print('Link clicked!');
                },
                child: Column(
                  children: [
                    Text('Find us on'),
                    Text('https://carol1532.com'),
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
