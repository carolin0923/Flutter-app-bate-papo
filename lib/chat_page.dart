import 'package:first_project_flutter/widgets/chat_bubble.dart';
import 'package:first_project_flutter/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPageArguments {
  final String username;
  ChatPageArguments(this.username);
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChatPageArguments;
    return Scaffold(
      //barra do aplicativo
      appBar: AppBar(
        title: Text('Hi ${args.username}'),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: Navigation back to LoginPage on logout

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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      alignment: index % 2 == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      message: "Hello, this is Carol!");
                }),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
