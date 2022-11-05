import 'package:todo_firestore/core/failures/failure.dart';

class UrlFormatFailure extends Failure {
  @override
  String get message => 'Url is invalid';
}
