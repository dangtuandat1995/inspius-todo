import 'package:flutter/material.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/features/todo/presentation/widgets/task_dialog.dart';
import 'package:todo_firestore/features/todo/presentation/widgets/todo_tab_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'TODO'),
              Tab(text: 'COMPLETED'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TodoTabView(taskStatus: TaskStatus.unfinished),
            TodoTabView(taskStatus: TaskStatus.complete),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'add todo',
          child: const Icon(Icons.add_circle),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const TaskDialog(id: ''),
            );
          },
        ),
      ),
    );
  }
}
