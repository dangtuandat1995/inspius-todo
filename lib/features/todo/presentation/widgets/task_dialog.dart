import 'package:flutter/material.dart';
import 'package:todo_firestore/features/todo/domain/usecases/create_task.dart';
import 'package:todo_firestore/features/todo/domain/usecases/update_task.dart';

import '../../domain/entities/user_task.dart';

class TaskDialog extends StatefulWidget {
  final String id;
  final String? title;
  final String? description;
  const TaskDialog({super.key, this.title, this.description, required this.id});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final TextEditingController titleController;
  late final TextEditingController descController;
  late final String dialogTitle;
  late final bool isCreateNewTask;

  final createTask = CreateTask();
  final updateTask = UpdateTask();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title ?? '');
    descController = TextEditingController(text: widget.description ?? '');
    if (widget.title != null || widget.description != null) {
      dialogTitle = 'Edit task';
      isCreateNewTask = false;
    } else {
      dialogTitle = 'Create task';
      isCreateNewTask = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Task title',
            ),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              hintText: 'Task description',
            ),
          ),
        ],
      ),
      actions: dialogActions(),
    );
  }

  List<Widget> dialogActions() {
    if (isCreateNewTask) {
      return [
        TextButton(
          onPressed: () async {
            await createTask(UserTask(
              id: widget.id,
              taskTitle: titleController.text,
              taskDesc: descController.text,
              taskStatus: TaskStatus.unfinished,
            ));
            if (!mounted) return;
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ];
    }
    return [
      TextButton(
        onPressed: () async {
          await updateTask(UserTask(
            id: widget.id,
            taskTitle: titleController.text,
            taskDesc: descController.text,
            taskStatus: TaskStatus.unfinished,
          ));
          if (!mounted) return;
          Navigator.of(context).pop();
        },
        child: const Text('Update'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
    ];
  }
}
