import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firestore/features/todo/data/models/user_task_model.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';

class ReadTask {
  Stream<List<UserTask>> call() {
    return FirebaseFirestore.instance
        .collection('todo')
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => UserTaskModel.fromJson(e.data()),
            )
            .toList());
  }
}
