import 'package:covid_api/model/newses.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/news.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE news (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            summary TEXT,
            country TEXT,
            author TEXT,
            link TEXT,
            media TEXT,
            title TEXT,
            topic TEXT,
            published_date TEXT,
            sId TEXT,
            score REAL
          )
        ''');
      },
    );
  }

  static Future<dynamic> insertNews(Newses news) async {
    final db = await database;
    await news.insertToDatabase(db);
    return true;
  }

  static Future<List<Newses>> getAllNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return List.generate(maps.length, (index) {
      return Newses.fromMap(maps[index]);
    });
  }

  static Future<void> deleteNews(int id) async {
    final db = await database;
    await db.delete(
      'news',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
