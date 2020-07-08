import 'package:flutter/cupertino.dart';

class Task {
  int id;
  String title;
  bool completed;

  Task({@required this.title, this.completed, id});

  void toogleCompleted() {
    completed = !completed;
  }

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json['id'],
        title: json['title'],
        completed: json['completed'] == 0 ? false : true,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 0 : 1,
    };
  }
}
