import 'package:flutter/material.dart';
import 'package:todos/screens/add_task_screen.dart';
import 'package:todos/tabs/all_tasks.dart';
import 'package:todos/tabs/completed_tasks.dart';
import 'package:todos/tabs/incomplete_tasks.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()));
              })
        ],
        bottom: TabBar(controller: tabController, tabs: <Widget>[
          Tab(text: 'All'),
          Tab(text: 'Incomplete'),
          Tab(text: 'Complete'),
        ]),
      ),
      body: TabBarView(controller: tabController, children: <Widget>[
        AllTasksTab(),
        IncompleteTasksTab(),
        CompletedTasksTab(),
      ]),
    );
  }
}
