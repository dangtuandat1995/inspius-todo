import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/usecase/usecase.dart';
import 'package:todo_firestore/features/todo/domain/repository/todo_repository.dart';

import '../entities/user_task.dart';

@injectable
class DeleteTask extends Usecase<void, UserTask> {
  final TodoRepository repository;

  DeleteTask({required this.repository});
  @override
  Future<Either<Failure, void>> call(UserTask param) async {
    return repository.deleteTask(param);
  }
}
