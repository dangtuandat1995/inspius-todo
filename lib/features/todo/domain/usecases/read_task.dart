import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/usecase/usecase.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';
import 'package:todo_firestore/features/todo/domain/repository/todo_repository.dart';

@injectable
class ReadTask extends Usecase<Stream<List<UserTask>>, NoParams> {
  final TodoRepository repository;

  ReadTask({required this.repository});

  @override
  Future<Either<Failure, Stream<List<UserTask>>>> call(NoParams param) {
    return repository.readTask();
  }
}
