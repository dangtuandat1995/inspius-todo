part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class CreateTaskEvent extends TodoEvent {
  final UserTask task;

  const CreateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class ReadTaskEvent extends TodoEvent {
  const ReadTaskEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTaskEvent extends TodoEvent {
  final UserTask task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TodoEvent {
  final UserTask task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
