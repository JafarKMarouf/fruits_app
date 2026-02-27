import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/show_filter_bottom_sheet.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/core/widgets/search_text_field.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/fruit_item_grid_view.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/show_more_best_selling.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/our_product_list_view.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/our_products_header.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: kTopPadding),
                  const CustomMainAppBar(title: 'المنتجات'),
                  const SizedBox(height: 16),
                  SearchTextField(
                    readOnly: true,
                    filter: () => showFilterBottomSheet(context),
                  ),
                  const SizedBox(height: 17),
                  const OurProductsHeader(),
                  const SizedBox(height: 8),
                  const OurProductListView(),
                  ShowMoreBestSelling(onTap: () {}),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            const FruitItemGridView(),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
