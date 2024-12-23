import 'package:first_project_flutter/chat_page.dart';
import 'package:first_project_flutter/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(primaryColor: Colors.green),
      home: ChatPage(),
    );
  }
}
