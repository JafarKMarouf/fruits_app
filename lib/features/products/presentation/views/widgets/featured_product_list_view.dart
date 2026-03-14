import 'package:flutter/material.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/featured_product_item.dart';

class FeaturedProductListView extends StatelessWidget {
  const FeaturedProductListView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return FeaturedProductItem(product: products[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 9);
        },
      ),
    );
  }
}
