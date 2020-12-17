import 'package:flutter/widgets.dart';
import 'package:to_do_list/db.helper.dart';
import 'package:to_do_list/task_model.dart';

// class Data{
//   // F
//   // List<Task> tasksLast = DBHelper.dbHelper.selectAllTask()
// }
class FavouritesProvider with ChangeNotifier {

  List<Task> tasksLast;
  Future isInitCompleted;
  List<Task> get tasks => [...tasksLast];

  FavouritesProvider() {
    isInitCompleted = fetchAndSetFav();
  }

  Future<List<Task>> fetchAndSetFav() async {
    final data = await DBHelper.dbHelper.selectAllTask();
    print(data);
    return data;
  }

}
