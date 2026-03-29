import 'package:fruits_app/core/services/local_storage_services/local_storage_service.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';

import '../../../../core/utils/constants/hive_box_name.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<void> saveCart(CartModel cart);
  Future<CartModel> getCart();
  Future<void> clearCart();
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  final LocalStorageService localStorageService;
  CartLocalDataSourceImpl(this.localStorageService);

  @override
  Future<void> saveCart(CartModel cart) async {
    await localStorageService.saveData(
      boxName: HiveBoxNames.cartBox,
      key: kCartKey,
      value: cart,
    );
  }

  @override
  Future<CartModel> getCart() async {
    final cart = await localStorageService.getData<CartModel>(
      boxName: HiveBoxNames.cartBox,
      key: kCartKey,
    );
    return cart ?? const CartModel(cartItems: [], totalPrice: 0);
  }

  @override
  Future<void> clearCart() async {
    await localStorageService.removeData(
      boxName: HiveBoxNames.cartBox,
      key: kCartKey,
    );
  }
}
