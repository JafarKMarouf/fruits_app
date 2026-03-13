import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, CartEntity>> getLocalCart();
  Future<Either<Failure, CartEntity>> addCartItem(CartItemEntity item);
  Future<Either<Failure, CartEntity>> decreaseCartItemCount(String productCode);
  Future<Either<Failure, CartEntity>> removeCartItem(String productCode);
  Future<Either<Failure, void>> syncCartWithRemote(String userId);
}
