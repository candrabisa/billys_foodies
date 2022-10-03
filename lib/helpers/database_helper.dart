import 'package:sqflite/sqflite.dart';

import '../../data/models/restaurant_result_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  static const String _tblRestoFavorite = 'favorited';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorited.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblRestoFavorite(
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL)''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantElement restaurant) async {
    final db = await database;
    await db!.insert(_tblRestoFavorite, restaurant.toJson());
  }

  Future<List<RestaurantElement>> getRestaurantFav() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblRestoFavorite);

    return result.map((e) => RestaurantElement.fromJson(e)).toList();
  }

  Future<Map> getRestaurantFavById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db!.query(
      _tblRestoFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> removeRestaurantFav(String id) async {
    final db = await database;

    await db!.delete(
      _tblRestoFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
