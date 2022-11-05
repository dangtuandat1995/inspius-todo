import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<LoremImageInfo>>> getImageInfo({
    required int page,
  });
}
