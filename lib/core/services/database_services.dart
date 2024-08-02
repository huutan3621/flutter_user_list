import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

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
      version: 2, // Increment version number if you're updating schema
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, firstName TEXT, lastName TEXT, avatar TEXT, isFavorite INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          // Add the isFavorite column to the existing table
          db.execute(
            'ALTER TABLE users ADD COLUMN isFavorite INTEGER DEFAULT 0',
          );
        }
      },
    );
  }

  Future<void> addUser(UserEntity user) async {
    try {
      final db = await database;

      // Debug print to check values
      debugPrint('Adding user: ${user.toMap()}');

      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('User added successfully');
    } catch (e) {
      debugPrint('Error adding user: $e');
      rethrow; // Re-throw the error for further handling
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
      final List<Map<String, dynamic>> maps =
          await db.query('users', columns: ['id']);
      return List.generate(maps.length, (i) => maps[i]['id'] as int);
    } catch (e) {
      debugPrint('Error getting user IDs: $e');
      rethrow;
    }
  }

  Future<List<UserEntity>> getUsers() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('users');
      return List.generate(maps.length, (i) => UserEntity.fromMap(maps[i]));
    } catch (e) {
      debugPrint('Error getting users: $e');
      rethrow;
    }
  }
}
