import 'package:equatable/equatable.dart';

enum TaskStatus { unfinished, complete }

class UserTask extends Equatable {
  final String id;
  final String taskTitle;
  final String taskDesc;
  final TaskStatus taskStatus;

  const UserTask({
    required this.id,
    required this.taskTitle,
    required this.taskDesc,
    required this.taskStatus,
  });

  @override
  List<Object?> get props => [id, taskTitle, taskDesc, taskStatus];
}
