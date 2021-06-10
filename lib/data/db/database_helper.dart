import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = "tblFavorite";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_tblFavorite (
        id TEXT PRIMARY KEY,
        name TEXT,
        pictureId TEXT,
        description TEXT,
        city TEXT,
        rating REAL
      )
      ''');
    }, version: 1);

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    return results.isNotEmpty ? results.first : {};
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
