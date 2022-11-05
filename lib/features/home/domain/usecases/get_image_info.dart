import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_firestore/core/usecase/usecase.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';
import 'package:todo_firestore/features/home/domain/repository/home_repository.dart';

@injectable
class GetImageInfo extends Usecase<List<LoremImageInfo>, int> {
  final HomeRepository repository;

  GetImageInfo({required this.repository});

  @override
  Future<Either<Failure, List<LoremImageInfo>>> call(int param) async {
    return repository.getImageInfo(page: param);
  }
}
