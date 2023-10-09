import 'dart:core';


import 'package:sqflite/sqflite.dart';
import 'package:untitled3/Model/Task.dart';



class DataBaseHelper {
  static Database? _dp;

  static Future<void> initDB() async {
    var databasepath = getDatabasesPath();
    String path = "${databasepath}todo.db";
    _dp = await openDatabase(path, version: 1, onOpen: (dp) {
      print("database opened");
    }, onCreate: (Database dp, int version) async {
      print("database created");
      await dp.execute(
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT,starttime TEXT,endtime Text,status TEXT, checked INTEGER,priority TEXT)");

    },
    );
  }

  static void insertTask(Task task) async {
    var res = await _dp!.rawInsert(
        "INSERT INTO tasks (id,title, description, starttime,endtime, date, status,checked,priority)VAlUES(?,?,?,?,?,?,?,?,?)",
        [null, task.title, task.description, task.startTime,task.endTime, task.date, task.status, task.Check,task.pr.toString().toLowerCase()]);
    print(res);
  }

  static Future<List<Task>> getallitems() async {
    List<Task> tasks = [];
    List<dynamic> r = await _dp!.query("tasks");
    for (var row in r) {
      int id = row["id"] as int;
      String title = row["title"] as String;
      String des = row["description"] as String;
      String date = row ['date'] as String;
      String StartTime = row['starttime'] as String;
      String endTime =row['endtime']as String;
      String status = row["status"] as String;
      int  intcheck= row['checked'] as int ;
      String priority=row['priority']as String;

      bool check = intcheck==1;
      Task task = new Task(
          id, title,
          StartTime,
          endTime,
          date,
          des,
          status,
          check,
      priority??'low' );

      tasks.add(task);
    }
    return tasks;
  }

  static deleteItem(int id) async {
    int resultStatus = await _dp!.delete(
        'tasks', where: "id = ?", whereArgs: [id]);
    print('Delete Res: $resultStatus');
  }

  static void update(Task task) async {
    _dp!.update('tasks', {
      'title': task.title,
      'date': task.date,
      'description': task.description,
      'starttime': task.startTime,
      'endtime':task.endTime,
      'status': task.status,
      'checked': task.Check,

    }, where: "id = ?",
        whereArgs: [task.id]);
  }
}

