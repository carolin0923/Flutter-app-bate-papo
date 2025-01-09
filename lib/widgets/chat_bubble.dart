import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Alignment alignment;
  const ChatBubble({super.key, required this.message, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 16),
            Image.network(
              'https://revistacarro.com.br/wp-content/uploads/2018/05/mini_cooper_s_cabrio.jpg',
              height: 100,
            )
          ],
        ),
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
      ),
    );
  }
}
