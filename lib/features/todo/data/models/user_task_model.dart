import 'package:json_annotation/json_annotation.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';

part 'user_task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserTaskModel extends UserTask {
  const UserTaskModel({
    required super.id,
    required super.taskTitle,
    required super.taskDesc,
    required super.taskStatus,
  });

  factory UserTaskModel.fromJson(Map<String, dynamic> json) =>
      _$UserTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserTaskModelToJson(this);
}
