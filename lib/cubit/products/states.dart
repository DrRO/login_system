abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {}

class ProductDetailsError extends ProductDetailsState {
  final String error;
  ProductDetailsError(this.error);
}