import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/our_product_item.dart';

class OurProductListView extends StatelessWidget {
  const OurProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) {
          return const OurProductItem(
            title: 'فروالة',
            image: AppImages.imagesStrawberry,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 9);
        },
      ),
    );
  }
}
