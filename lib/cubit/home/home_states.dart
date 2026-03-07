abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class ProfileLoaded extends HomeState {}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}