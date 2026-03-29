import 'package:fruits_app/core/services/store_services/database_service.dart';
import 'package:fruits_app/core/utils/constants/backend_endpoints.dart';
import 'package:fruits_app/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<void> syncCart(String userId, CartModel cart);
  Future<CartModel?> fetchCart({required String userId});
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final DatabaseService databaseService;

  CartRemoteDataSourceImpl(this.databaseService);

  String _cartPath(String userId) =>
      '${BackendEndpoints.getUser}/$userId/${BackendEndpoints.syncCart}';

  @override
  Future<void> syncCart(String userId, CartModel cart) async {
    final path = _cartPath(userId);

    await databaseService.addData(
      path: path,
      data: cart.toJson(),
      documentId: 'cart_data',
    );
  }

  @override
  Future<CartModel?> fetchCart({required String userId}) async {
    final path = _cartPath(userId);

    final data = await databaseService.getData(
      path: path,
      documentId: 'cart_data',
    );
    if (data == null || data.isEmpty) return null;

    return CartModel.fromJson(data);
  }
}
