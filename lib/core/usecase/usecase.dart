import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/failures/failure.dart';

abstract class Usecase<ReturnType, Param> {
  Future<Either<Failure, ReturnType>> call(Param param);
}
