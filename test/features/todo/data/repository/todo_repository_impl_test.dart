import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_firestore/core/failures/connection_failure.dart';
import 'package:todo_firestore/features/todo/data/data_source/todo_data_source.dart';
import 'package:todo_firestore/features/todo/data/repository/todo_repository_impl.dart';
import 'package:todo_firestore/features/todo/domain/entities/user_task.dart';

import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoDataSource])
void main() {
  late MockTodoDataSource mockTodoDataSource;
  late TodoRepositoryImpl repositoryImpl;

  setUp(() {
    mockTodoDataSource = MockTodoDataSource();
    repositoryImpl = TodoRepositoryImpl(dataSource: mockTodoDataSource);
  });

  const mockTask = UserTask(
    id: 'id',
    taskTitle: 'taskTitle',
    taskDesc: 'taskDesc',
    taskStatus: TaskStatus.unfinished,
  );

  test('should return failure when data source return failure', () async {
    // arrange
    when(mockTodoDataSource.getTodoCollection())
        .thenAnswer((realInvocation) async => Left(ConnectionFailure()));
    // act
    final result = await repositoryImpl.createTask(mockTask);
    // assert
    expect(result, equals(Left(ConnectionFailure())));
  });
}
