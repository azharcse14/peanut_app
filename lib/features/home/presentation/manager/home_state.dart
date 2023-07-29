part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}


class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String error;

  const HomeError({required this.error});
}

class HomeAccessDenied extends HomeState {


  const HomeAccessDenied();
}

class HomeSuccess extends HomeState {
  final List<OpenTradesEntity> openTradesEntity;
  final totalProfit;

  const HomeSuccess({
    required this.openTradesEntity,
    required this.totalProfit,
  });
}
