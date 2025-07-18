import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/article.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'favorites';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    try {
      String path = join(await getDatabasesPath(), 'news_app.db');
      
      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        url TEXT NOT NULL,
        urlToImage TEXT,
        publishedAt TEXT NOT NULL,
        author TEXT,
        source TEXT
      )
    ''');
  }

  Future<void> addToFavorites(Article article) async {
    final db = await database;
    await db.insert(
      _tableName,
      article.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFromFavorites(String articleId) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [articleId],
    );
  }

  Future<List<Article>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return Article.fromDatabase(maps[i]);
    });
  }

  Future<bool> isFavorite(String articleId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [articleId],
    );
    
    return maps.isNotEmpty;
  }

  Future<void> clearFavorites() async {
    final db = await database;
    await db.delete(_tableName);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
