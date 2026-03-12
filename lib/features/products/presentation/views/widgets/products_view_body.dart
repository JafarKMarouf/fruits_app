import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubits/featured_products/featured_product_cubit.dart';
import 'package:fruits_app/core/cubits/product/product_cubit.dart';
import 'package:fruits_app/core/helper/show_filter_bottom_sheet.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/core/widgets/search_text_field.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/show_more_best_selling.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/featured_product_list_view_bloc_builder.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/featured_products_header.dart';

import '../../../../home/presentation/views/widgets/products_grid_view_bloc_builder.dart'
    show ProductsGridViewBlocBuilder;

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    context.read<ProductCubit>().getProducts();
    context.read<FeaturedProductCubit>().getFeaturedProducts();
    super.initState();
  }

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
                  const FeaturedProductsHeader(),
                  const SizedBox(height: 8),
                  const FeaturedProductListViewBlocBuilder(),
                  ShowMoreBestSelling(onTap: () {}),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const ProductsGridViewBlocBuilder(),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
