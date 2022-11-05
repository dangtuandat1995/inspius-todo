import 'package:todo_firestore/core/failures/failure.dart';

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown error occurred!';
}
