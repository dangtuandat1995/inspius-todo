import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/features/todo/presentation/provider/todo_provider.dart';
import 'package:todo_firestore/features/todo/presentation/widgets/task_dialog.dart';
import 'package:todo_firestore/features/todo/presentation/widgets/todo_tab_view.dart';

import '../bloc/todo_bloc.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Stream<List<UserTask>> taskStream;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const ReadTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Todo page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'TODO'),
              Tab(text: 'COMPLETED'),
            ],
          ),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Okay'),
                    ),
                  ],
                ),
              );
            } else if (state is CreateTaskState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New task is created!')),
              );
            } else if (state is ReadTaskState) {
              taskStream = state.taskStream;
              taskStream.listen((tasks) {
                _scaffoldKey.currentContext?.read<TodoProvider>().tasks = tasks;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Subscribed to firestore!')),
              );
            } else if (state is UpdateTaskState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task information is updated!')),
              );
            } else if (state is DeleteTaskState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task is deleted!')),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                const TabBarView(
                  children: [
                    TodoTabView(taskStatus: TaskStatus.unfinished),
                    TodoTabView(taskStatus: TaskStatus.complete),
                  ],
                ),
                if (state is LoadingState)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
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
