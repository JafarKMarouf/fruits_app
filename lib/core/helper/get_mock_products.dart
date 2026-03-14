import '../entities/product_entity.dart';

List<ProductEntity> getMockProducts() {
  return List.generate(
    6,
    (index) => ProductEntity(
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
  );
}
