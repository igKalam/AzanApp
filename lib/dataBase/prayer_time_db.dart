import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_ffi.dart
import 'package:path/path.dart';

class PrayerTimeDatabaseHelper {
  static Database? _database; 
  static const String tableName = 'prayers';
  static const String dbName = 'dataContainer.db';

  // Ensure only one instance of the database exists
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> initializeDatabase() async {
    // Use sqflite_ffi's databaseFactory getter directly
    String path = await getDatabasesPath();
    //databaseFactory = databaseFactoryFfi;
    return openDatabase(
      join(path, dbName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableName(name TEXT PRIMARY KEY, time TEXT, ikama TEXT)",
        );
      },
      singleInstance: true,
      version: 1,
    );
  }

  // Insert or update an alarm
  Future<void> setPrayer(String name, String time,  String ikama) async {
    final db = await database;
    await db.insert(
      tableName,
      {'name': name, 'time': time, 'ikama': ikama},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all alarms
  Future<List<Map<String, dynamic>>> getAllPrayers() async {
    final db = await database;
    return await db.query(tableName);
  }

  // Get alarm by name
  Future<Map<String, dynamic>?> getPrayerByName(String name) async {
    final db = await database;
    List<Map<String, dynamic>> alarms = await db.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    return alarms.isNotEmpty ? alarms.first : null;
  }
}
