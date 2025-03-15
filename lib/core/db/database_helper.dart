import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT, status TEXT, species TEXT, image TEXT, favorite INTEGER)",
        );
      },
      version: 1,
    );
  }

  Database get database => _database!;
}
