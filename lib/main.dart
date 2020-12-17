import 'package:flutter/material.dart';
import 'package:to_do_list/ToDoList.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ToDoList() ,
      debugShowCheckedModeBanner: false,
    );

  }

}
