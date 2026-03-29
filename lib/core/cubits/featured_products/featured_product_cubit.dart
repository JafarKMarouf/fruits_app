import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/product_entity.dart';
import '../../repositories/product_repo/product_repo.dart';

part 'featured_product_state.dart';

class FeaturedProductCubit extends Cubit<FeaturedProductState> {
  final ProductRepo productRepo;
  FeaturedProductCubit(this.productRepo) : super(FeaturedProductInitial());

  Future<void> getFeaturedProducts() async {
    emit(FeaturedProductLoading());
    var result = await productRepo.getFeaturedProducts();
    result.fold(
      (fail) => emit(FeaturedProductFailure(errMessage: fail.message)),
      (products) => emit(FeaturedProductSuccess(products: products)),
    );
  }
}
