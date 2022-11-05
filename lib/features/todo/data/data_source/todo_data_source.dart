import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_firestore/core/failures/connection_failure.dart';
import 'package:todo_firestore/core/failures/failure.dart';

@injectable
class TodoDataSource {
  final InternetConnectionChecker connectionChecker;

  TodoDataSource({required this.connectionChecker});

  Future<Either<Failure, CollectionReference<Map<String, dynamic>>>>
      getTodoCollection() async {
    final isConnected = await connectionChecker.hasConnection;
    if (!isConnected) return Left(ConnectionFailure());

    return Right(FirebaseFirestore.instance.collection('todo'));
  }
}
