import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';

List<CartItemEntity> getMockCartItems() {
  return List.generate(
    6,
    (index) => CartItemEntity(
      productEntity: ProductEntity(
        name: 'Loading Product Name',
        price: 0.0,
        quantity: 0,
        description:
            'This is a long description placeholder to simulate the layout of the product details section.',
        imageUrl: null,
        isFeatured: false,
        code: '000000',
        expirationMonths: 0,
        numberOfCalories: 0,
        unitAmount: 0,
        isOrganic: false,
        avgRate: 5,
        countRate: 10,
        reviews: [],
      ),
      count: 30,
    ),
  );
}
