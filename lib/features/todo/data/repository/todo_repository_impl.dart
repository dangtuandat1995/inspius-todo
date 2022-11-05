import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/unknown_failure.dart';
import 'package:todo_firestore/features/todo/data/data_source/todo_data_source.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/features/todo/domain/repository/todo_repository.dart';

import '../models/user_task_model.dart';

@Injectable(as: TodoRepository)
class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> createTask(UserTask task) async {
    final collection = await dataSource.getTodoCollection();
    return collection.fold(
      (l) => Left(l),
      (r) async {
        try {
          final doc = r.doc();
          final taskWithId = UserTaskModel(
            id: doc.id,
            taskTitle: task.taskTitle,
            taskDesc: task.taskDesc,
            taskStatus: task.taskStatus,
          );
          await doc.set(taskWithId.toJson());
          return const Right(null);
        } catch (e) {
          return Left(UnknownFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteTask(UserTask task) async {
    final collection = await dataSource.getTodoCollection();
    return collection.fold(
      (l) => Left(l),
      (r) async {
        try {
          final doc = r.doc(task.id);
          await doc.delete();
          return const Right(null);
        } catch (e) {
          return Left(UnknownFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, Stream<List<UserTask>>>> readTask() async {
    final collection = await dataSource.getTodoCollection();
    return collection.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(r.snapshots().map((event) => event.docs
              .map(
                (e) => UserTaskModel.fromJson(e.data()),
              )
              .toList()));
        } catch (e) {
          return Left(UnknownFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateTask(UserTask task) async {
    final collection = await dataSource.getTodoCollection();
    return collection.fold(
      (l) => Left(l),
      (r) async {
        try {
          final doc = r.doc(task.id);
          final taskWithId = UserTaskModel(
            id: task.id,
            taskTitle: task.taskTitle,
            taskDesc: task.taskDesc,
            taskStatus: task.taskStatus,
          );
          await doc.update(taskWithId.toJson());
          return const Right(null);
        } catch (e) {
          return Left(UnknownFailure());
        }
      },
    );
  }
}
