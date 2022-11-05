part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetImageInfoEvent extends HomeEvent {
  final int page;

  const GetImageInfoEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
