import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/ToDoList.dart';
import 'package:to_do_list/task_provider.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<TaskProvider>(
      create: (context) {
        return TaskProvider();
      },
      child: MaterialApp(
        home: Consumer<TaskProvider>(
          builder: (context, value, child) {
            if(value.isInitCompleted){
              return ToDoList();
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ) ,
        debugShowCheckedModeBanner: false,
      ),
    );

  }

}
