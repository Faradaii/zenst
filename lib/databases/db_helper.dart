import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:zenst/models/user.dart';
import 'package:zenst/models/notification.dart';
import 'package:zenst/models/bookmark.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE notification (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        notifikasi TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE bookmark (
        id TEXT PRIMARY KEY,
        userId INTEGER,
        imagePath TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        price REAL,
        imagePath TEXT,
        totalSold INTEGER
      )
    ''');
  }
// CRUD operations for users
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // CRUD operations for notifications
  Future<void> insertNotification(Notification notification) async {
    final db = await database;
    await db.insert('notification', notification.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Notification>> getAllNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notification');
    return List.generate(maps.length, (i) {
      return Notification.fromMap(maps[i]);
    });
  }

  Future<Notification?> getNotificationById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notification',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Notification.fromMap(maps.first);
    }
    return null;
  }

  // CRUD operations for bookmarks
  Future<void> insertBookmark(Bookmark bookmark) async {
    final db = await database;
    await db.insert('bookmark', bookmark.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Bookmark>> getAllBookmarks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmark');
    return List.generate(maps.length, (i) {
      return Bookmark.fromMap(maps[i]);
    });
  }
  Future<List<String>> getAllBookmarksString() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmark');
    return List.generate(maps.length, (i) {
      return maps[i]['id'].toString();
    });
  }

  Future<bool> getBookmarkById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'bookmark',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return true;
    }
    return false;
  }
}