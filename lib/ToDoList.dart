import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/NewTask.dart';
import 'package:to_do_list/db.helper.dart';
import 'package:to_do_list/task_model.dart';

import 'Task_Widget.dart';
import 'constants.dart';

class ToDoList extends StatefulWidget{
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NewTask()));
        }, child: Icon(Icons.add),),
        appBar: AppBar(
          title: Text('To Do List'),
          bottom: TabBar(tabs: [
            Tab(text: 'All Task',),
            Tab(text: 'Completed Task',),
            Tab(text: 'Incompleted Task',),
          ],isScrollable: true, controller: tabController,),
        ),
        body:
    Provider(
    create:(_) => FavouritesProvider() ,
    child:
        Column(
              children: [
                Expanded(
                  child: TabBarView(children:[
                    AllTask(),
                    CompletedTask(),
                    InCompletedTask(),
                  ], controller: tabController,),
                ),
              ],
            ),
    )
          ),
    );

  }
}

class AllTask extends StatefulWidget{

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: Provider.of<FavouritesProvider>(context).fetchAndSetFav(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                setChange(){
                  setState(() {

                  });
                }
                print(snapshot.data);
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TaskWidget(snapshot.data[index],setChange);
                  },
                );
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
            }else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          );

  }
}



class CompletedTask extends StatefulWidget{
  @override
  _CompletedTaskState createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FavouritesProvider>(context).fetchAndSetFav(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            setChange(){
              setState(() {

              });
            }
            print(snapshot.data);
             List<Task> t = snapshot.data.where((element) => element.isCompleted == true).toList();
            return ListView.builder(
              itemCount: t.length,
              itemBuilder: (context, index) {

                return TaskWidget(t[index],setChange);
              },
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        }else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
    // return Container(
    //   child: Column(
    //       children: tasksLast.where((element) => element.isCompleted == true).map((e) => TaskWidget(e,myfun)).toList()
    //   ),
    // );
  }
}


class InCompletedTask extends StatefulWidget{
  @override
  _InCompletedTaskState createState() => _InCompletedTaskState();
}

class _InCompletedTaskState extends State<InCompletedTask> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FavouritesProvider>(context).fetchAndSetFav(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            setChange(){
              setState(() {

              });
            }
            print(snapshot.data);
            List<Task> t = snapshot.data.where((element) => element.isCompleted == false).toList();
            return ListView.builder(
              itemCount: t.length,
              itemBuilder: (context, index) {

                return TaskWidget(t[index],setChange);
              },
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        }else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}