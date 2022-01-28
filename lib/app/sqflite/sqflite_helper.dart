import 'dart:async';
import 'dart:io';
import 'package:app/app/models/create_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteHelper {
  SqfliteHelper._();

  static final SqfliteHelper instace = SqfliteHelper._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;
    return await initDatabase();
  }

  Future<Database?> initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_create);
  }

  String get _create => '''
      CREATE TABLE crud (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          descricao TEXT,
          imagem TEXT
        );
  ''';
}
