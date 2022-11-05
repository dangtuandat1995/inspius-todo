import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_firestore/features/todo/presentation/provider/todo_provider.dart';

import '../../domain/entities/user_task.dart';
import 'task_dialog.dart';

class TodoTabView extends StatefulWidget {
  final TaskStatus taskStatus;
  const TodoTabView({super.key, required this.taskStatus});

  @override
  State<TodoTabView> createState() => _TodoTabViewState();
}

class _TodoTabViewState extends State<TodoTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Selector<TodoProvider, List<UserTask>>(
      selector: (_, provider) => provider.tasks,
      builder: (context, tasks, child) {
        final filteredTasks = tasks
            .where(
              (element) => element.taskStatus == widget.taskStatus,
            )
            .toList();

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemBuilder: (context, index) {
            final todo = filteredTasks[index];
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.read<TodoBloc>().add(DeleteTaskEvent(
                            task: todo,
                          ));
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
                    context.read<TodoBloc>().add(UpdateTaskEvent(
                          task: UserTask(
                            id: todo.id,
                            taskTitle: todo.taskTitle,
                            taskDesc: todo.taskDesc,
                            taskStatus:
                                widget.taskStatus == TaskStatus.unfinished
                                    ? TaskStatus.complete
                                    : TaskStatus.unfinished,
                          ),
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
            return const Divider(height: 10);
          },
          itemCount: filteredTasks.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
