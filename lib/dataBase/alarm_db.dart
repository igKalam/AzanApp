import 'package:azanalexa/models/models.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_ffi.dart
import 'package:path/path.dart';
import '../services/logger.dart';
class AlarmDatabaseHelper {
  static Database? _database = null; 
  static Log log = Log();
  static const String tableName = 'alarmTiming';
  static const String dbName = 'dataContainer.db';

  // Ensure only one instance of the database exists
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database?> initializeDatabase() async {
    String path = await getDatabasesPath();
    Database? database;
  try {
    database = await openDatabase(
      join(path, dbName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableName(name TEXT PRIMARY KEY, time INTEGER)",
        );
      },
      singleInstance: true,
      version: 1,
    );
  } catch (e) {
    log.writeLog(LogType.error, e.toString());
    print("error on creating");
  }
  return database;
  }

  // Insert or update an alarm
  Future<void> setAlarm(String name, int time) async {
    final db = await database;
    await db.insert(
      tableName,
      {'name': name, 'time': time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all alarms
  Future<List<Map<String, dynamic>>> getAlarms() async {
    final db = await database;
    return await db.query(tableName);
  }

  // Get alarm by name
  Future<Map<String, dynamic>?> getAlarmByName(String name) async {
    final db = await database;
    List<Map<String, dynamic>> alarms = await db.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    return alarms.isNotEmpty ? alarms.first : null;
  }

  // Get alarm by time
  Future<Map<String, dynamic>?> getAlarmByTime(int time) async {
    final db = await database;
    List<Map<String, dynamic>> alarms = await db.query(
      tableName,
      where: 'time = ?',
      whereArgs: [time],
    );
    return alarms.isNotEmpty ? alarms.first : null;
  }
}
