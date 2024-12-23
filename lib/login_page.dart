import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Button clicked');
        },
      ),
      body: Column(
        children: [
          Text('Lest\'s sign you in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5)),
          Center(
            child: Text(
              'Welcome back! \n You\'ve been missed!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.yellow),
            ),
          ),
          Image.network(
              'https://revistacarro.com.br/wp-content/uploads/2018/05/mini_cooper_s_cabrio.jpg',
              height: 150),
          Container(
            height: 150,
            width: 150,
            color: Colors.blue,
            padding: EdgeInsets.all(50),
            child: FlutterLogo(),
          )
        ],
      ),
    );
  }
}
