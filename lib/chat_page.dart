import 'dart:convert';

import 'package:first_project_flutter/models/chat_message_entity.dart';
import 'package:first_project_flutter/widgets/chat_bubble.dart';
import 'package:first_project_flutter/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPageArguments {
  final String username;
  ChatPageArguments(this.username);
}

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //initiate state of messages
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');

    final List<dynamic> decodedList = jsonDecode(response) as List;

    final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();

    print(_chatMessages.length);

    //final state of the messages
    setState(() {
      _messages = _chatMessages;
    });
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

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
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      alignment: _messages[index].author.userName == 'Carol123'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      entity: _messages[index]);
                }),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
