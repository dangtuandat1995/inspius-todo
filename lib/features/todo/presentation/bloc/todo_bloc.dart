import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/usecase/usecase.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/features/todo/domain/usecases/create_task.dart';
import 'package:todo_firestore/features/todo/domain/usecases/delete_task.dart';
import 'package:todo_firestore/features/todo/domain/usecases/read_task.dart';
import 'package:todo_firestore/features/todo/domain/usecases/update_task.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTask createTask;
  final ReadTask readTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  TodoBloc({
    required this.createTask,
    required this.readTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if (event is CreateTaskEvent) {
        emit(LoadingState());
        final result = await createTask(event.task);
        result.fold(
          (l) => emit(ErrorState(message: l.message)),
          (r) => emit(CreateTaskState()),
        );
      } else if (event is ReadTaskEvent) {
        emit(LoadingState());
        final result = await readTask(NoParams());
        result.fold(
          (l) => emit(ErrorState(message: l.message)),
          (r) => emit(ReadTaskState(taskStream: r)),
        );
      } else if (event is UpdateTaskEvent) {
        emit(LoadingState());
        final result = await updateTask(event.task);
        result.fold(
          (l) => emit(ErrorState(message: l.message)),
          (r) => emit(UpdateTaskState()),
        );
      } else if (event is DeleteTaskEvent) {
        emit(LoadingState());
        final result = await deleteTask(event.task);
        result.fold(
          (l) => emit(ErrorState(message: l.message)),
          (r) => emit(DeleteTaskState()),
        );
      }
    });
  }
}
