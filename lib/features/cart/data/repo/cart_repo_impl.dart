import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_app/features/cart/domain/repo/cart_repo.dart';

import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

class CartRepoImpl implements CartRepo {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;

  CartRepoImpl({required this.localDataSource, required this.remoteDataSource});

  num _calculateTotal(List<CartItemModel> items) {
    num total = 0;
    for (var item in items) {
      total += (item.productModel.price * item.count);
    }
    return total;
  }

  @override
  Future<Either<Failure, CartEntity>> addCartItem(CartItemEntity item) async {
    try {
      final currentCart = await localDataSource.getCart();
      final items = List<CartItemModel>.from(currentCart.cartItems);

      // Check if product already exists in cart
      final existingIndex = items.indexWhere(
        (i) => i.productModel.code == item.productEntity.code,
      );

      if (existingIndex >= 0) {
        items[existingIndex].count += item.count;
      } else {
        items.add(CartItemModel.fromEntity(item));
      }

      final updatedCart = CartModel(
        cartItems: items,
        totalPrice: _calculateTotal(items),
      );

      await localDataSource.saveCart(updatedCart);
      return Right(updatedCart.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getLocalCart() async {
    try {
      final cartModel = await localDataSource.getCart();
      return Right(cartModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeCartItem(String productId) async {
    try {
      final currentCart = await localDataSource.getCart();
      final items = List<CartItemModel>.from(currentCart.cartItems);

      items.removeWhere((i) => i.productModel.code == productId);

      final updatedCart = CartModel(
        cartItems: items,
        totalPrice: _calculateTotal(items),
      );

      await localDataSource.saveCart(updatedCart);
      return Right(updatedCart.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncCartWithRemote(String userId) async {
    try {
      // 1. Get remote cart
      final remoteCart = await remoteDataSource.fetchCart(userId: userId);
      final localCart = await localDataSource.getCart();

      if (remoteCart != null) {
        // Simple Sync strategy: Remote overwrites Local (You can adjust this to merge them if needed)
        await localDataSource.saveCart(remoteCart);
      } else {
        // If no remote cart exists, push the local one to Firestore
        await remoteDataSource.syncCart(userId, localCart);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
