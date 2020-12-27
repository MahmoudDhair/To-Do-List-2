import 'package:flutter/widgets.dart';
import 'package:to_do_list/db.helper.dart';
import 'package:to_do_list/task_model.dart';

// class Data{
//   // F
//   // List<Task> tasksLast = DBHelper.dbHelper.selectAllTask()
// }
class TaskProvider with ChangeNotifier {

  List<Task> tasksList;
  bool isInitCompleted = false ;
  List<Task> get tasks => [...tasksList];


  TaskProvider() {
    getTasks();
  }

  Future<List<Task>> getTasks() async {
    final data = await DBHelper.dbHelper.selectAllTask();
    tasksList = data ;
    isInitCompleted = true;
    notifyListeners();
    return data;
  }

  void deleteTask(Task task) async {
    DBHelper.dbHelper.deleteTask(task);
    getTasks();
  }

  void updateTask(Task task) async {
    DBHelper.dbHelper.updateTask(task);
    getTasks();
  }

  void insertNewTask(Task task) async {
    DBHelper.dbHelper.insertNewTask(task);
    getTasks();
  }

}
