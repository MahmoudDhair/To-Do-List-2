import 'package:flutter/material.dart';
import 'package:to_do_list/db.helper.dart';
import 'package:to_do_list/task_model.dart';

import 'constants.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String task;

  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(

              onChanged: (value) {
                this.task = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Task Name ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Is Completed"),
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    this.isCompleted = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                DBHelper.dbHelper.insertNewTask(
                    Task(taskName: this.task, isCompleted: this.isCompleted));
                DBHelper.dbHelper.selectAllTask();
                Navigator.pop(context);
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
