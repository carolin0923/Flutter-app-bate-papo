import 'package:first_project_flutter/models/chat_message.dart';
import 'package:first_project_flutter/providers/chat_provider.dart';
import 'package:first_project_flutter/widgets/chat_bubble.dart';
import 'package:first_project_flutter/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider_authProvider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //criar um metodo aqui no whidget pai e o chat input que é o whidget filho chamar esse metodo la
  onMessageSent(ChatMessage message) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).loadInitialMessages();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final username = authProvider.currentUsername;
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      //barra do aplicativo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi ${authProvider.currentUsername}'),
        actions: [
          IconButton(
              onPressed: () {
                authProvider.logout();

                Navigator.popAndPushNamed(context, '/');
                print('Icon pressed');
              },
              icon: Icon(Icons
                  .logout)) // aqui preciso dizer oq ue fazer quando o clique acontecer
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messages[index];
                  return ChatBubble(
                    alignment:
                        message.author.userName == authProvider.currentUsername
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    message: message,
                  );
                }),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
