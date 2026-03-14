import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/product_entity.dart';
import '../../repositories/product_repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;
  ProductCubit(this.productRepo) : super(ProductInitial());

  Future<void> getBestSelling() async {
    emit(ProductLoading());
    var result = await productRepo.getBestSellingProducts();
    result.fold(
      (fail) => emit(ProductFailure(errMessage: fail.message)),
      (products) => emit(ProductSuccess(products: products)),
    );
  }

  Future<void> getProducts() async {
    emit(ProductLoading());
    var result = await productRepo.getProducts();
    result.fold(
      (fail) => emit(ProductFailure(errMessage: fail.message)),
      (products) => emit(ProductSuccess(products: products)),
    );
  }
}
