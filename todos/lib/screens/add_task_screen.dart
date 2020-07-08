import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/db/db_provider.dart';
import 'package:todos/models/task.dart';
import 'package:todos/providers/todos_model.dart';
import 'dart:math' as math;

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskTitleController = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    // data for testing
    List<Task> testClients = [
      Task(title: "test", completed: false),
      Task(title: "test 01", completed: false),
      Task(title: "test 02", completed: false),
    ];

    Task rnd = testClients[math.Random().nextInt(testClients.length)];
    DBProvider.db.newTask(rnd);

    if (textVal.isNotEmpty) {
      final Task todo = Task(title: textVal, completed: completed);
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: taskTitleController,
                  ),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked;
                    }),
                    title: Text('Complete?'),
                  ),
                  RaisedButton(
                    onPressed: onAdd,
                    child: Text('Add'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
