import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  // Load the cart instantly from Hive
  Future<void> loadCart() async {
    emit(CartLoading());
    final result = await cartRepo.getLocalCart();
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  // Add item and update UI
  Future<void> addItem(CartItemEntity item) async {
    final result = await cartRepo.addCartItem(item);
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (updatedCart) => emit(CartLoaded(updatedCart)),
    );
  }

  // Remove item and update UI
  Future<void> removeItem(String productId) async {
    final result = await cartRepo.removeCartItem(productId);
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (updatedCart) => emit(CartLoaded(updatedCart)),
    );
  }

  // Sync with Firestore (Call this after login or in background)
  Future<void> syncCart(String userId) async {
    final result = await cartRepo.syncCartWithRemote(userId);
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (_) => loadCart(), // Reload from local after sync is complete
    );
  }
}
