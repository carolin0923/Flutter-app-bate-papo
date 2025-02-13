import 'package:first_project_flutter/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_authProvider.dart';

//bolhas do chat
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Alignment alignment;

  const ChatBubble({super.key, required this.alignment, required this.message});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    //compare dynamically the name of the author whith the logged in user
    bool isAuthor = message.author.userName == authProvider.currentUsername;

    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            if (message.imageUrl != null)
              Image.network(
                '${message.imageUrl}',
                height: 200,
              )
          ],
        ),
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
            color: isAuthor ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
      ),
    );
  }
}
