import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/usecase/usecase.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/features/todo/domain/repository/todo_repository.dart';

@injectable
class CreateTask extends Usecase<void, UserTask> {
  final TodoRepository repository;

  CreateTask({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserTask param) async {
    return repository.createTask(param);
  }
}
