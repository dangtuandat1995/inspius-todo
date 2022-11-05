import 'package:flutter/material.dart';

import '../../domain/entities/user_task.dart';

class TodoProvider extends ChangeNotifier {
  List<UserTask> _tasks = [];

  List<UserTask> get tasks => _tasks;

  set tasks(List<UserTask> val) {
    _tasks = val;
    notifyListeners();
  }
}
