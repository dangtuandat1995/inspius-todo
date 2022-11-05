import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTask {
  Future<void> call(String taskId) async {
    final doc = FirebaseFirestore.instance.collection('todo').doc(taskId);
    await doc.delete();
  }
}
