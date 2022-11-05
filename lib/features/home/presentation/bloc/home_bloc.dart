import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';
import 'package:todo_firestore/features/home/domain/usecases/get_image_info.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetImageInfo getImageInfo;
  HomeBloc({
    required this.getImageInfo,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetImageInfoEvent) {
        emit(HomeLoadingState());
        final result = await getImageInfo(event.page);

        result.fold(
          (l) => emit(HomeErrorState(message: l.message)),
          (r) => emit(GetImageInfoState(imageInfos: r)),
        );
      }
    });
  }
}
