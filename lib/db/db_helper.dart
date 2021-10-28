import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    return await db!.insert(_tableName, task!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await db!.query(_tableName);
  }

  static delete(Task task) async {
    return await db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await db!.rawUpdate('''
    UPDATE task 
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
