import 'dart:developer';

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

      final existingIndex = items.indexWhere(
        (i) => i.productModel.code == item.productEntity.code,
      );

      if (existingIndex >= 0) {
        items[existingIndex].count += item.count;
      } else {
        items.add(CartItemModel.fromEntity(item));
      }

      return Right(await _updateCart(items));
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
  Future<Either<Failure, CartEntity>> removeCartItem(String productCode) async {
    try {
      final currentCart = await localDataSource.getCart();
      final items = List<CartItemModel>.from(currentCart.cartItems);

      items.removeWhere((i) => i.productModel.code == productCode);

      return Right(await _updateCart(items));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> decreaseCartItemCount(
    String productCode,
  ) async {
    try {
      final currentCart = await localDataSource.getCart();
      final items = List<CartItemModel>.from(currentCart.cartItems);

      final index = items.indexWhere((i) => i.productModel.code == productCode);

      if (index >= 0) {
        if (items[index].count > 1) {
          items[index].count -= 1;
        } else {
          items.removeAt(index);
        }

        return Right(await _updateCart(items));
      } else {
        return const Left(CacheFailure('Product not found in cart'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncCartWithRemote(String userId) async {
    try {
      final localCart = await localDataSource.getCart();

      if (localCart.cartItems.isEmpty) {
        log('--- Local empty, checking remote ---');
        final remoteCart = await remoteDataSource.fetchCart(userId: userId);

        if (remoteCart != null && remoteCart.cartItems.isNotEmpty) {
          log('--- Remote data found, saving to local ---');
          await localDataSource.saveCart(remoteCart);
        } else {
          log('--- Remote also empty, pushing initial state ---');
          return const Right(null);
          // await remoteDataSource.syncCart(userId, localCart);
        }
      } else {
        log('--- Local has data, pushing to remote ---');
        await remoteDataSource.syncCart(userId, localCart);
      }
      return const Right(null);
    } catch (e) {
      log('--- Sync Error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<CartEntity> _updateCart(List<CartItemModel> items) async {
    final updatedCart = CartModel(
      cartItems: items,
      totalPrice: _calculateTotal(items),
    );

    await localDataSource.saveCart(updatedCart);
    return updatedCart.toEntity();
  }

  @override
  Future<Either<Failure, void>> saveToRemote(String userId) async {
    try {
      final localCart = await localDataSource.getCart();
      await remoteDataSource.syncCart(userId, localCart);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
