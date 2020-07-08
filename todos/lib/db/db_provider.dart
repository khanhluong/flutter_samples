import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos/models/task.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TasksDB.db");

    String sql = "CREATE TABLE Tasks ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title TEXT,"
        "completed BIT"
        ")";

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });
  }

  //add new Task
  newTask(Task newTask) async {
    final db = await database;

    var raw = await db.rawInsert(
        'INSERT INTO Tasks(title, completed) values (?, ?)',
        [newTask.title, newTask.completed ? 0 : 1]);
    return raw;
  }

  completedOrNotCompleted(Task newTask) async {
    final db = await database;

    Task completed = Task(title: newTask.title, completed: !newTask.completed);
    var res = await db.update('Tasks', completed.toMap(),
        where: 'id = ?', whereArgs: [newTask.id]);

    return res;
  }

  updateTask(Task task) async {
    final db = await database;
    var res = await db
        .update("Tasks", task.toMap(), where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  getAllTasksDemo() async {
    final db = await database;
    var res = await db.query('Tasks');
    return res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
  }

  getTask(int id) async {}

  Future<List<Task>> getCompletedTasks() async {
    final db = await database;
    var res = await db.query('Tasks', where: 'completed = ?', whereArgs: [1]);
    List<Task> taskList =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return taskList;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    var res = await db.query('Tasks');
    return res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
  }

  deleteTask(int id) async {
    final db = await database;
    return db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }

  deleteAllTasks() async {
    final db = await database;
    db.rawDelete('Delete * from Tasks');
  }
}
