import 'package:first_project_flutter/database/app_database.dart';
import 'package:first_project_flutter/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final AppDatabase _database = AppDatabase.instance;
  List<ChatMessage> _messages = [];
  bool _loadingDatabase = false;

  List<ChatMessage> get messages => _messages;

  bool get loadindDatabase => _loadingDatabase;

  //em vez de carregar mensagens do arquivo Json, agora usar o banco de dados

  Future<void> loadInitialMessages() async {
    _loadingDatabase = true;
    notifyListeners();
    try {
      _messages = await _database.getAllMessages();
    } catch (e) {
      print('Error when loading message: $e');
    } finally {
      _loadingDatabase = false;
      notifyListeners();
    }
  }

  //add uma nova mesnagem

  Future<void> addMessage(ChatMessage message) async {
    try {
      // Insere a mensagem e captura o ID gerado
      final id = await _database.insertMessage(message);
      print('Mensagem salva com ID: $id');
      // Atualiza o objeto com o ID gerado pelo banco
      final messageWithId = ChatMessage(
        id: id,
        text: message.text,
        imageUrl: message.imageUrl,
        author: message.author,
        createdAt: message.createdAt,
      );
      _messages.add(messageWithId);
      notifyListeners();
    } catch (e) {
      print('Error when saving message: $e');
    }
  }
}
