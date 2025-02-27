import 'package:first_project_flutter/chat_page.dart';
import 'package:first_project_flutter/login_page.dart';
import 'package:first_project_flutter/providers/chat_provider.dart';
import 'package:first_project_flutter/providers/provider_authProvider.dart';
import 'package:first_project_flutter/sign_up_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadUser();

  runApp(ChatApp(authProvider: authProvider));
}

class ChatApp extends StatelessWidget {
  final AuthProvider authProvider;

  const ChatApp({super.key, required this.authProvider});

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        initialRoute:
            authProvider.currentUserEmail != null ? '/chat' : '/signin',
        routes: {
          '/signin': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/chat': (context) => ChatPage(),
        },
      ),
    );
  }
}
