import 'dart:convert';

import 'package:first_project_flutter/models/chat_message_entity.dart';

import 'package:first_project_flutter/widgets/chat_bubble.dart';
import 'package:first_project_flutter/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/provider_authProvider.dart';

class ChatPageArguments {
  final String username;
  ChatPageArguments(this.username);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //initiate state of messages
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');

    final List<dynamic> decodedList = jsonDecode(response) as List;

    final List<ChatMessageEntity> chatMessages = decodedList.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();

    //print(_chatMessages.length);

    //final state of the messages
    setState(() {
      _messages = chatMessages;
    });
  }

  //criar um metodo aqui no whidget pai e o chat input que é o whidget filho chamar esse metodo la
  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    print(
        'ChatPage received username: ${ModalRoute.of(context)!.settings.arguments}');
    final args = ModalRoute.of(context)!.settings.arguments;

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
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    alignment: _messages[index].author.userName == ''
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    entity: _messages[index],
                    currentUsername: '',
                  );
                }),
          ),
          ChatInput(
            onSubmit: onMessageSent,
            currentUsername: '',
          ),
        ],
      ),
    );
  }
}
