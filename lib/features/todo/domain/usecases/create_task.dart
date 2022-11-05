import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firestore/features/todo/data/models/user_task_model.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';

class CreateTask {
  Future<void> call(UserTask task) async {
    final doc = FirebaseFirestore.instance.collection('todo').doc();
    final taskWithId = UserTaskModel(
      id: doc.id,
      taskTitle: task.taskTitle,
      taskDesc: task.taskDesc,
      taskStatus: task.taskStatus,
    );
    await doc.set(taskWithId.toJson());
  }
}
