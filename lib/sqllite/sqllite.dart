import 'package:flutter_application_1/socket/socket.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseApp{
  static final DataBaseApp _instance = DataBaseApp._internal();
  factory DataBaseApp() => _instance;

  Database? _database;

  DataBaseApp._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'messages.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            uuid TEXT,
            chatId INTEGER,
            text TEXT,
            status INTEGER,
            date INTEGER
          )
        ''');
      },
    );
  }
  void drop()async{
    final db = await database;
     await db.execute('''
          drop table messages
        ''');
  }
  void create()async{
    final db = await database;
    await db.execute('''
          CREATE TABLE messages (
            uuid TEXT,
            chatId INTEGER,
            text TEXT,
            status INTEGER,
            date INTEGER
          )
        ''');
  }


  // Future<List<AppMessage>> getMessagesByChatId(int chatId) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'messages',
  //     where: 'chatId = ?',
  //     whereArgs: [chatId],
  //   );

  //   return List.generate(
  //     maps.length,
  //     (index) => AppMessage(
  //       uuid: maps[index]['uuid'],
  //       text: maps[index]['text'],
  //       status: maps[index]['status'], 
  //       chatId: maps[index]["chatId"],
  //       date: maps[index]["date"]
  //     ),
  //   );
  // }

  // Future<List<AppMessage>> getMessages() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'messages',
  //   );

  //   return List.generate(
  //     maps.length,
  //     (index) => AppMessage(
  //       uuid: maps[index]['uuid'],
  //       text: maps[index]['text'],
  //       status: maps[index]['status'], 
  //       chatId: maps[index]["chatId"],
  //       date: maps[index]["date"]
  //     ),
  //   );
  // }


  Future<void> insertMessage(AppMessage message) async {
    final db = await database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Future<void> updateMessageStatus(int messageId, bool status) async {
  //   final db = await database;
  //   await db.update(
  //     'messages',
  //     {'status': status ? 1 : 0}, // 1 = true, 0 = false
  //     where: 'id = ?',
  //     whereArgs: [messageId],
  //   );
  // }



}