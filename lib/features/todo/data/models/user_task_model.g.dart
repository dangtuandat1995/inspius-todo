// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTaskModel _$UserTaskModelFromJson(Map<String, dynamic> json) =>
    UserTaskModel(
      id: json['id'] as String,
      taskTitle: json['task_title'] as String,
      taskDesc: json['task_desc'] as String,
      taskStatus: $enumDecode(_$TaskStatusEnumMap, json['task_status']),
    );

Map<String, dynamic> _$UserTaskModelToJson(UserTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_title': instance.taskTitle,
      'task_desc': instance.taskDesc,
      'task_status': _$TaskStatusEnumMap[instance.taskStatus]!,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.unfinished: 'unfinished',
  TaskStatus.complete: 'complete',
};
