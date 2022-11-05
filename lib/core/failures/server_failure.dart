import 'package:todo_firestore/core/failures/failure.dart';

class ServerFailure extends Failure {
  @override
  String get message => 'There\'s something wrong with the server!';

  @override
  List<Object?> get props => [message];
}
