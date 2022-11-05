part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends TodoState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends TodoState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateTaskState extends TodoState {
  @override
  List<Object?> get props => [];
}

class ReadTaskState extends TodoState {
  final Stream<List<UserTask>> taskStream;

  const ReadTaskState({required this.taskStream});

  @override
  List<Object?> get props => [taskStream];
}

class UpdateTaskState extends TodoState {
  @override
  List<Object?> get props => [];
}

class DeleteTaskState extends TodoState {
  @override
  List<Object?> get props => [];
}
