import 'package:first_project_flutter/models/chat_message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChatDatabase {
  ChatDatabase._privateConstructor();
  // CRIAR UMA INSTANCIA DE CHATDATABASE
  static final ChatDatabase instance = ChatDatabase._privateConstructor();

  //instanciando do SQLite/conectando com banco de dados
  static Database? _database;

  final String databaseName = "ChaApp.db";

//todos esperam o bando de dados ficar pronto antes de usa-lo
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

//criar a tabela
  Future<void> _onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE messages (id INTEGER PRIMARY KEY, text TEXT NOT NULL, imageUrl TEXT, createdAt INTEGER NOT NULL, author TEXT NOT NULL )');
  }

  Future<Database> _initDatabase() async {
    final databasePath =
        await getDatabasesPath(); //solicitando/perguntando onde guardar esse banco de dados
    return openDatabase(
      /*path*/ join(databasePath, databaseName),
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE messages ADD COLUMN imageUrl TEXT');
        }
      },
    ); //abriando/criando o banco de dados
  }

  //INSIRIR MENSAGENS
  Future<int> insertMessage(ChatMessage message) async {
    final db = await database;
    final id = await db.insert('messages', message.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

//Buscar/recupera mensagens
  Future<List<ChatMessage>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('messages');
    return maps.map((map) => ChatMessage.fromJson(map)).toList();
  }

// deletar messagens (renover mensagens pelo id)
  Future<int> deleteMessage(int id) async {
    final db = await database;
    return await db.delete('messages', where: 'id = ?', whereArgs: [id]);
  }
}
