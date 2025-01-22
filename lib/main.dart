import 'package:first_project_flutter/chat_page.dart';
import 'package:first_project_flutter/login_page.dart';
import 'package:first_project_flutter/providers/provider_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderCounter()),
      ],
      child: ChatApp(),
    ),
  );
}

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
      home: LoginPage(),
      routes: {'/chat': (context) => ChatPage()},
    );
  }
}
