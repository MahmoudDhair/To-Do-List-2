import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_list/task_model.dart';

class DBHelper {
  DBHelper._();

  static final String databaseName = 'tasksDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompletedColumnName = 'isCompleted';
  static final int databaseVersion = 1;

  static DBHelper dbHelper = DBHelper._();
  Database database;

  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    // Get a location using getDatabasesPath
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database = await openDatabase(
        path,
        version: databaseVersion,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
         $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
         $taskNameColumnName TEXT NOT NULL,
         $taskIsCompletedColumnName INTEGER
         )''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int x = await database.insert(DBHelper.tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> selectAllTask() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(DBHelper.tableName);
      // print(result);
      List<Task> tasks = result.map((e) => Task.formJson(e)).toList();
      //print(tasks[1].taskName);
      return tasks;
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<dynamic> selectSpecificTask(String name) async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(DBHelper.tableName,where: '$taskNameColumnName=?',whereArgs: [name]);
      print(result);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.update(DBHelper.tableName, task.toJson(),where: '$taskNameColumnName=?',whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.delete(DBHelper.tableName,where: '$taskNameColumnName=?',whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
