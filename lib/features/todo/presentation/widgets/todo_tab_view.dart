import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/entities/user_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/read_task.dart';
import '../../domain/usecases/update_task.dart';
import 'task_dialog.dart';

class TodoTabView extends StatefulWidget {
  final TaskStatus taskStatus;
  const TodoTabView({super.key, required this.taskStatus});

  @override
  State<TodoTabView> createState() => _TodoTabViewState();
}

class _TodoTabViewState extends State<TodoTabView> {
  final updateTask = UpdateTask();
  final readTask = ReadTask();
  final deleteTask = DeleteTask();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserTask>>(
      initialData: const [],
      stream: readTask(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return const SizedBox();
        final todos = snapshot.data!
            .where(
              (element) => element.taskStatus == widget.taskStatus,
            )
            .toList();

        return ListView.separated(
          itemBuilder: (context, index) {
            final todo = todos[index];
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      deleteTask(todo.id);
                    },
                    label: 'Delete',
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(todo.taskTitle),
                subtitle: Text(todo.taskDesc),
                leading: IconButton(
                  icon: widget.taskStatus == TaskStatus.unfinished
                      ? const Icon(Icons.check_box_outline_blank)
                      : const Icon(Icons.check_box, color: Colors.green),
                  onPressed: () {
                    updateTask(UserTask(
                      id: todo.id,
                      taskTitle: todo.taskTitle,
                      taskDesc: todo.taskDesc,
                      taskStatus: widget.taskStatus == TaskStatus.unfinished
                          ? TaskStatus.complete
                          : TaskStatus.unfinished,
                    ));
                  },
                ),
                trailing: widget.taskStatus == TaskStatus.unfinished
                    ? IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => TaskDialog(
                              id: todo.id,
                              title: todo.taskTitle,
                              description: todo.taskDesc,
                            ),
                          );
                        },
                      )
                    : null,
              ),
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(height: 10);
          },
          itemCount: todos.length,
        );
      },
    );
  }
}
