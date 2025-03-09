import 'package:first_project_flutter/models/chat_message.dart';
import 'package:first_project_flutter/models/user_registration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._privateConstructor();

  // CRIAR UMA INSTANCIA DE DATABASE
  static final AppDatabase instance = AppDatabase._privateConstructor();

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
    print('Creating tables...');
    await database.execute(
        'CREATE TABLE messages (id INTEGER PRIMARY KEY, text TEXT NOT NULL, imageUrl TEXT, createdAt INTEGER NOT NULL, author TEXT NOT NULL )');

    await database.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE NULL, email TEXT UNIQUE NOT NULL, password TEXT NOT NULL)');
    print('Tables created successfully.');
  }

  Future<Database> _initDatabase() async {
    final databasePath =
        await getDatabasesPath(); //solicitando/perguntando onde guardar esse banco de dados
    final dbPath = join(databasePath, databaseName);

    print('Initializing new database...');
    return openDatabase(dbPath, version: 3, onCreate: _onCreate,
        onUpgrade: (db, oldVersion, newVersion) async {
      print('Upgrading database from version $oldVersion to $newVersion...');
      if (oldVersion < 3) {
        await db.execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE NOT NULL, email TEXT UNIQUE NOT NULL, password TEXT NOT NULL)');
        print('Table users created during upgrade.');
      }
    }); //abriando/criando o banco de dados
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

// deletar messagens (remover mensagens pelo id)
  Future<int> deleteMessage(int id) async {
    final db = await database;
    return await db.delete('messages', where: 'id = ?', whereArgs: [id]);
  }

  //insirir um novo usuario
  Future<int> insertUser(UserRegistration user) async {
    final db = await database;

    final id = await db.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Listar todos os usuarios
  Future<List<UserRegistration?>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps.map((map) => UserRegistration.fromJson(map)).toList();
  }

  //buscar o usario por email
  Future< /*como??*/ UserRegistration?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (maps.isNotEmpty) {
      print('user found: ${maps.first}');
      return UserRegistration.fromJson(maps.first);
    }
    print('user not found: $email');
    return null;
  }

  //atualizar um usuario (com senha)
  Future<UserRegistration?> updateUser(UserRegistration user) async {
    final db = await database;
    final Map<String, dynamic> updates = {
      'username': user.username,
      'password': user.password
    };
    try {
      final linhasAtualizadas = await db
          .update('users', updates, where: 'id = ?', whereArgs: [user.id]);

      if (linhasAtualizadas > 0) {
        return user;
      }
      return null;
    } catch (e) {
      print('Erro ao atualizar o usario no banco de dados: $e');
      return null;
    }
  }
}
