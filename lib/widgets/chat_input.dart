import 'package:first_project_flutter/models/chat_message_entity.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSubmit;
  final String currentUsername;

  ChatInput({super.key, required this.onSubmit, required this.currentUsername});

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() {
    print('ChatMessage: ${chatMessageController.text}');

    //            criando um novo objeto para a nova mensagem que o usuario digitar
    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        author: Author(userName: currentUsername));

    //aqui o whidget filho está acionando o metodo do pai no chat_page
    onSubmit(newChatMessage);
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
            onPressed: onSendButtonPressed,
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
