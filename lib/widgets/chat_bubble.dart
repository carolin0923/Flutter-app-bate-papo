import 'package:first_project_flutter/models/chat_message_entity.dart';
import 'package:flutter/material.dart';

//bolhas do chat
class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;
  final String currentUsername;

  const ChatBubble(
      {super.key,
      required this.alignment,
      required this.entity,
      required this.currentUsername});

  @override
  Widget build(BuildContext context) {
    //compare dynamically the name of the author whith the logged in user
    bool isAuthor = entity.author.userName == currentUsername;

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
              entity.text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            if (entity.imageUrl != null)
              Image.network(
                '${entity.imageUrl}',
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
