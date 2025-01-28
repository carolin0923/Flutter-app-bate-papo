import 'package:first_project_flutter/chat_page.dart';
import 'package:first_project_flutter/login_page.dart';
import 'package:first_project_flutter/providers/provider_authProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/chat': (context) => ChatPage(),
        },
      ),
    );
  }
}



/*
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue, foregroundColor: Colors.black)),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
*/