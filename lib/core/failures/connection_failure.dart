import 'package:todo_firestore/core/failures/failure.dart';

class ConnectionFailure extends Failure {
  @override
  String get message => 'Device has no Internet connection!';

  @override
  List<Object?> get props => [message];
}
