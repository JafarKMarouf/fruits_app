part of 'featured_product_cubit.dart';

sealed class FeaturedProductState {}

final class FeaturedProductInitial extends FeaturedProductState {}

final class FeaturedProductLoading extends FeaturedProductState {}

final class FeaturedProductFailure extends FeaturedProductState {
  final String errMessage;

  FeaturedProductFailure({required this.errMessage});
}

final class FeaturedProductSuccess extends FeaturedProductState {
  final List<ProductEntity> products;
  FeaturedProductSuccess({required this.products});
}
