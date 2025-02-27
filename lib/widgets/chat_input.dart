import 'package:first_project_flutter/models/chat_message.dart';
import 'package:first_project_flutter/providers/chat_provider.dart';
import 'package:first_project_flutter/providers/provider_authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatelessWidget {
  ChatInput({super.key});

  final chatMessageController = TextEditingController();

  void onSendButtonPressed(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final chatprovider = Provider.of<ChatProvider>(context, listen: false);
    final messageText = chatMessageController.text.trim();

    if (messageText.isEmpty) return;

    print('ChatMessage: ${chatMessageController.text}');

    //            criando um novo objeto para a nova mensagem que o usuario digitar
    final newMessage = ChatMessage(
        imageUrl: ' ',
        text: messageText,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        author: Author(userName: authProvider.currentUserEmail ?? 'Anonymous'));

    print('Nova mensagem criada: ${newMessage.text}');
    chatprovider.addMessage(newMessage).then((_) {
      chatMessageController.clear();
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending message!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // ignore: sort_child_properties_last
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            //BOTAO DE ADCIONAR
            onPressed: () {},
            icon: Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
              child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            controller: chatMessageController,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Type your message",
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: InputBorder.none),
          )), // add um espaço entre os buttons

          IconButton(
            // Botão de enviar
            onPressed: () => onSendButtonPressed(context),
            icon: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }
}
