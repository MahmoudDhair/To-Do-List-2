import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/db.helper.dart';
import 'package:to_do_list/task_model.dart';

class TaskWidget extends StatefulWidget{
  Task task;
  Function setChange;
  TaskWidget(this.task,this.setChange);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
   return Card(
     margin: EdgeInsets.all(10),
     child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           FlatButton(onPressed: () {
             showDialog(
                 context: context,
                 builder: (context){
                   return SearchFilter(this.widget.task,widget.setChange);
                 }
             );
           }, child: Icon(Icons.delete)),
           Text(this.widget.task.taskName),
           Checkbox(value: this.widget.task.isCompleted, onChanged: (value) {
             setState(() {
               this.widget.task.isCompleted = value;
                DBHelper.dbHelper.updateTask(Task(taskName: this.widget.task.taskName,isCompleted: value));
             });

           },)
         ],
       ),
     ),
   );
  }
}

class SearchFilter extends StatefulWidget {
Task _task ;
Function function;
SearchFilter(this._task,this.function);
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Delete",),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text('OK',style: TextStyle(color: Colors.red),),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: ()  {

              DBHelper.dbHelper.deleteTask(this.widget._task);
              this.widget.function();
              Navigator.of(context).pop();




          },
        ),
      ],
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: Text("Are You Sure To Delete This Task ?")
            ),
          ],
        ),
      ),
    );
  }
}