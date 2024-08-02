import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'users.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY)',
        );
      },
    );
  }

  Future<void> addUser(int id) async {
    try {
      final db = await database;
      await db.insert(
        'users',
        {'id': id},
        conflictAlgorithm:
            ConflictAlgorithm.ignore, // Ignore if the item already exists
      );
    } catch (e) {
      debugPrint('Error adding user: $e');
      rethrow;
    }
  }

  Future<void> removeUser(int id) async {
    try {
      final db = await database;
      await db.delete('users', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint('Error removing user: $e');
      rethrow;
    }
  }

  Future<List<int>> getUserIds() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('users');
      return List.generate(maps.length, (i) {
        return maps[i]['id'] as int;
      });
    } catch (e) {
      debugPrint('Error getting user IDs: $e');
      rethrow;
    }
  }
}
