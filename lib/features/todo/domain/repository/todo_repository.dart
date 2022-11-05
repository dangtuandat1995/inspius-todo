import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';

abstract class TodoRepository {
  Future<Either<Failure, void>> createTask(UserTask task);
  Future<Either<Failure, Stream<List<UserTask>>>> readTask();
  Future<Either<Failure, void>> updateTask(UserTask task);
  Future<Either<Failure, void>> deleteTask(UserTask task);
}
