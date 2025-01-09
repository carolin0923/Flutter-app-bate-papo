import 'package:first_project_flutter/widgets/chat_bubble.dart';
import 'package:first_project_flutter/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String username;
  const ChatPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra do aplicativo
      appBar: AppBar(
        title: Text('Hi $username'),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: Navigation back to LoginPage on logout

                Navigator.pop(context);
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
