part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState({required this.message});

  @override
  List<Object?> get props => [message, DateTime.now()];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetImageInfoState extends HomeState {
  final List<LoremImageInfo> imageInfos;

  const GetImageInfoState({required this.imageInfos});

  @override
  List<Object?> get props => [imageInfos];
}
