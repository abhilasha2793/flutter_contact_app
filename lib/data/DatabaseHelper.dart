import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/contact.dart';

// A class for managing database operations
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
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mobile TEXT,
        landLine TEXT,
        imageUrl TEXT,
        favorite INTEGER DEFAULT 0
      )
    ''');
  }

  Future<List<Contact>> getContacts({bool favorite = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'contacts',
      where: favorite ? 'favorite = ?' : null,
      whereArgs: favorite ? [1] : null,
      orderBy: 'name ASC',
    );

    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        mobile: maps[i]['mobile'],
        landLine: maps[i]['landLine'],
        imageUrl: maps[i]['imageUrl'],
        favorite: maps[i]['favorite'] == 1,
      );
    });
  }

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateContact(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int contactId) async {
    final db = await database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [contactId]);
  }


  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}