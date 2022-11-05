import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:todo_firestore/core/service/network_service.dart';
import 'package:todo_firestore/features/home/data/models/lorem_image_info_model.dart';

@injectable
class HomeRemoteDataSource {
  final NetworkService networkService;

  HomeRemoteDataSource({required this.networkService});

  Future<Either<Failure, List<LoremImageInfoModel>>> getImageInfo(
      int page) async {
    final result = await networkService.request(
      url: 'https://picsum.photos/v2/list',
      parameters: {
        'page': page,
        'limit': 5,
      },
    );

    return result.fold(
      (failure) => Left(failure),
      (result) {
        final listResult = List<LoremImageInfoModel>.from(
          (result as List<dynamic>).map(
            (e) => LoremImageInfoModel.fromJson(e),
          ),
        );

        return Right(listResult);
      },
    );
  }
}
