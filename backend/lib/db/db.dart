import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class DatabaseHelper {
  late Database _db;

  Database get db => _db;

  // Inicializando o banco de dados
  void initDb() {
    final dbPath = p.join(Directory.current.path, 'db', 'barbershop.db');
    _db = sqlite3.open(dbPath);

    // Criar tabela de usuários, se não existir
    _db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        avatar TEXT,
        profile TEXT,
        work_days TEXT,
        work_hours TEXT,
        barbershop_id INTEGER
      )
    ''');
  }
}
