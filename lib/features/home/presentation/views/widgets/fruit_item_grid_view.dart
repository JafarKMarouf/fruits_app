import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/widgets/fruit_item.dart';
import 'package:fruits_app/features/home/domain/entities/product_entity.dart';

class FruitItemGridView extends StatelessWidget {
  const FruitItemGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 163 / 214,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const FruitItem(
          product: ProductEntity(
            title: 'بطيخ',
            image: AppImages.imagesWatermelon,
            price: 30,
          ),
        );
      },
    );
  }
}
