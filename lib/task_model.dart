import 'package:to_do_list/db.helper.dart';

class Task {
  String taskName;
  bool isCompleted;
  Task({this.taskName, this.isCompleted});

  Task.formJson(Map<String,dynamic> map){
    this.taskName = map[DBHelper.taskNameColumnName];
    this.isCompleted = map[DBHelper.taskIsCompletedColumnName] == 1 ? true : false;
  }
  toJson(){
    return{
      DBHelper.taskNameColumnName : this.taskName,
      DBHelper.taskIsCompletedColumnName : this.isCompleted ? 1 : 0
    };
  }
}