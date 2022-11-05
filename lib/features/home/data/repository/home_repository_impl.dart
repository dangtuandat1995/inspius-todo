import 'package:injectable/injectable.dart';
import 'package:todo_firestore/features/home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/features/home/domain/repository/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<LoremImageInfo>>> getImageInfo({
    required int page,
  }) async {
    return dataSource.getImageInfo(page);
  }
}
